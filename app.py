import streamlit as st
import pandas as pd


# ============================================================
# PAGE SETTINGS
# ============================================================

st.set_page_config(
    page_title="SmartSale Dashboard",
    page_icon="📊",
    layout="wide"
)


# ============================================================
# CUSTOM UI STYLE
# ============================================================

st.markdown(
    """
    <style>

    .block-container {
        padding-top: 2rem;
        padding-bottom: 3rem;
    }

    .main-title {
        font-size: 2.6rem;
        font-weight: 700;
        margin-bottom: 0.2rem;
    }

    .subtitle {
        color: #9ca3af;
        font-size: 1rem;
        margin-bottom: 1.5rem;
    }

    .section-title {
        font-size: 1.35rem;
        font-weight: 650;
        margin-top: 1rem;
        margin-bottom: 0.8rem;
    }

    div[data-testid="stMetric"] {
        background-color: #1f2937;
        border: 1px solid #374151;
        border-radius: 12px;
        padding: 18px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.20);
    }

    div[data-testid="stMetricLabel"] {
        color: #d1d5db !important;
        font-size: 0.9rem;
    }

    div[data-testid="stMetricValue"] {
        color: #ffffff !important;
        font-size: 1.7rem;
        font-weight: 650;
    }

    div[data-testid="stMetricDelta"] {
        color: #d1d5db !important;
    }

    .info-card {
        background-color: #1f2937;
        border: 1px solid #374151;
        border-radius: 12px;
        padding: 16px;
        margin-bottom: 12px;
        color: #ffffff !important;
    }

    .footer {
        text-align: center;
        color: #9ca3af;
        font-size: 0.8rem;
        padding-top: 2rem;
    }

    </style>
    """,
    unsafe_allow_html=True
)


# ============================================================
# LOAD PREDICTION DATA
# ============================================================

prediction_data = pd.read_csv(
    "data/processed/sales_predictions.csv"
)

prediction_data["Date"] = pd.to_datetime(
    prediction_data["Date"]
)


# ============================================================
# HEADER
# ============================================================

st.markdown(
    '<div class="main-title">📊 SmartSale</div>',
    unsafe_allow_html=True
)

st.markdown(
    '<div class="subtitle">'
    'ML-Based Retail Sales Forecasting & Inventory Recommendation System'
    '</div>',
    unsafe_allow_html=True
)

st.divider()


# ============================================================
# INVENTORY SETTINGS
# ============================================================

st.markdown(
    '<div class="section-title">⚙️ Inventory Settings</div>',
    unsafe_allow_html=True
)

col1, col2 = st.columns(2)

with col1:
    current_stock = st.number_input(
        "Current Stock",
        min_value=0.0,
        value=1000.0,
        step=100.0,
        help="Enter the current available stock."
    )

with col2:
    safety_stock_percent = st.number_input(
        "Safety Stock %",
        min_value=0.0,
        max_value=100.0,
        value=10.0,
        step=1.0,
        help="Safety stock percentage used for inventory planning."
    )


# ============================================================
# INVENTORY CALCULATION
# ============================================================

prediction_data["Safety_Stock"] = (
    prediction_data["Predicted_Sales"]
    * safety_stock_percent
    / 100
)

prediction_data["Recommended_Stock"] = (
    prediction_data["Predicted_Sales"]
    + prediction_data["Safety_Stock"]
    - current_stock
).clip(lower=0)


st.divider()


# ============================================================
# DASHBOARD METRICS
# ============================================================

st.markdown(
    '<div class="section-title">📈 Sales Forecasting Dashboard</div>',
    unsafe_allow_html=True
)

total_sales = prediction_data["Sales"].sum()

total_predicted_sales = (
    prediction_data["Predicted_Sales"].sum()
)

total_recommended_stock = (
    prediction_data["Recommended_Stock"].sum()
)

total_stores = prediction_data["Store"].nunique()


col1, col2, col3, col4 = st.columns(4)

with col1:
    st.metric(
        "Actual Sales",
        f"{total_sales:,.0f}"
    )

with col2:
    st.metric(
        "Predicted Sales",
        f"{total_predicted_sales:,.0f}"
    )

with col3:
    st.metric(
        "Recommended Stock",
        f"{total_recommended_stock:,.0f}"
    )

with col4:
    st.metric(
        "Active Stores",
        total_stores
    )


st.divider()


# ============================================================
# STORE SELECTION
# ============================================================

st.markdown(
    '<div class="section-title">🏪 Store Analysis</div>',
    unsafe_allow_html=True
)

store_list = sorted(
    prediction_data["Store"].unique()
)

selected_store = st.selectbox(
    "Select Store",
    store_list,
    help=(
        "Choose a store to view its sales prediction "
        "and inventory recommendation."
    )
)

store_data = prediction_data[
    prediction_data["Store"] == selected_store
].copy()


st.markdown(
    f"""
    <div class="info-card">
        <b>Selected Store:</b> {selected_store}
    </div>
    """,
    unsafe_allow_html=True
)


# ============================================================
# DATE FILTER
# ============================================================

st.markdown(
    '<div class="section-title">📅 Date Filter</div>',
    unsafe_allow_html=True
)

min_date = store_data["Date"].min().date()
max_date = store_data["Date"].max().date()

selected_dates = st.date_input(
    "Select Date Range",
    value=(min_date, max_date),
    min_value=min_date,
    max_value=max_date,
    help="Select the date range for the selected store."
)


# ============================================================
# FILTER STORE DATA
# ============================================================

if len(selected_dates) == 2:

    start_date = pd.to_datetime(
        selected_dates[0]
    )

    end_date = pd.to_datetime(
        selected_dates[1]
    )

    filtered_store_data = store_data[
        (store_data["Date"] >= start_date)
        & (store_data["Date"] <= end_date)
    ].copy()

    st.caption(
        f"Showing data from "
        f"{selected_dates[0].strftime('%d %b %Y')} "
        f"to "
        f"{selected_dates[1].strftime('%d %b %Y')}"
    )

else:

    filtered_store_data = store_data.copy()

    st.caption(
        "Please select a start date and end date."
    )


st.caption(
    f"📊 Records: {len(filtered_store_data):,}"
)


# ============================================================
# SELECTED STORE SUMMARY
# ============================================================

st.markdown(
    '<div class="section-title">📦 Selected Store Summary</div>',
    unsafe_allow_html=True
)

if filtered_store_data.empty:

    st.warning(
        "No data is available for the selected date range."
    )

else:

    store_predicted_sales = (
        filtered_store_data["Predicted_Sales"].sum()
    )

    store_safety_stock = (
        filtered_store_data["Safety_Stock"].sum()
    )

    store_recommended_stock = (
        filtered_store_data["Recommended_Stock"].sum()
    )

    col1, col2, col3 = st.columns(3)

    with col1:
        st.metric(
            "Predicted Sales",
            f"{store_predicted_sales:,.0f}"
        )

    with col2:
        st.metric(
            "Safety Stock",
            f"{store_safety_stock:,.0f}"
        )

    with col3:
        st.metric(
            "Recommended Stock",
            f"{store_recommended_stock:,.0f}"
        )


# ============================================================
# SELECTED STORE DETAILS
# ============================================================

st.markdown(
    '<div class="section-title">📋 Selected Store Details</div>',
    unsafe_allow_html=True
)

if not filtered_store_data.empty:

    st.dataframe(
        filtered_store_data[
            [
                "Store",
                "Date",
                "Predicted_Sales",
                "Safety_Stock",
                "Recommended_Stock"
            ]
        ],
        use_container_width=True,
        hide_index=True
    )

else:

    st.info(
        "No store details available for the selected date range."
    )


# ============================================================
# DOWNLOAD FILTERED STORE DATA
# ============================================================

if not filtered_store_data.empty:

    st.download_button(
        label="⬇️ Download Selected Store Data",
        data=filtered_store_data[
            [
                "Store",
                "Date",
                "Sales",
                "Predicted_Sales",
                "Safety_Stock",
                "Recommended_Stock"
            ]
        ].to_csv(index=False).encode("utf-8"),
        file_name=(
            f"store_{selected_store}_sales_report.csv"
        ),
        mime="text/csv"
    )


# ============================================================
# ACTUAL VS PREDICTED SALES
# ============================================================

st.markdown(
    '<div class="section-title">📊 Actual vs Predicted Sales</div>',
    unsafe_allow_html=True
)

if not filtered_store_data.empty:

    chart_data = filtered_store_data[
        [
            "Date",
            "Sales",
            "Predicted_Sales"
        ]
    ].copy()

    chart_data = chart_data.set_index(
        "Date"
    )

    st.line_chart(
        chart_data[
            [
                "Sales",
                "Predicted_Sales"
            ]
        ],
        use_container_width=True
    )

else:

    st.info(
        "Sales chart is unavailable for the selected date range."
    )


# ============================================================
# INVENTORY REQUIREMENT TREND
# ============================================================

st.markdown(
    '<div class="section-title">📦 Inventory Requirement Trend</div>',
    unsafe_allow_html=True
)

if not filtered_store_data.empty:

    inventory_chart_data = filtered_store_data[
        [
            "Date",
            "Predicted_Sales",
            "Recommended_Stock"
        ]
    ].copy()

    inventory_chart_data = (
        inventory_chart_data.set_index("Date")
    )

    st.line_chart(
        inventory_chart_data[
            [
                "Predicted_Sales",
                "Recommended_Stock"
            ]
        ],
        use_container_width=True
    )

else:

    st.info(
        "Inventory trend is unavailable for the selected date range."
    )


# ============================================================
# SALES PREDICTION DATA
# ============================================================

with st.expander(
    "🔮 Sales Prediction Data",
    expanded=False
):

    st.caption(
        "Preview of the sales prediction dataset."
    )

    st.dataframe(
        prediction_data[
            [
                "Store",
                "Date",
                "Sales",
                "Predicted_Sales"
            ]
        ].head(20),
        use_container_width=True,
        hide_index=True
    )


# ============================================================
# LIVE INVENTORY RECOMMENDATION
# ============================================================

with st.expander(
    "📦 Live Inventory Recommendation",
    expanded=False
):

    st.caption(
        "Recommendations are calculated using the selected "
        "Safety Stock % and Current Stock inputs."
    )

    st.dataframe(
        prediction_data[
            [
                "Store",
                "Date",
                "Predicted_Sales",
                "Safety_Stock",
                "Recommended_Stock"
            ]
        ].head(20),
        use_container_width=True,
        hide_index=True
    )


# ============================================================
# FOOTER
# ============================================================

st.markdown(
    """
    <div class="footer">
        SmartSale • ML-Based Retail Sales Forecasting & Inventory Recommendation
    </div>
    """,
    unsafe_allow_html=True
)