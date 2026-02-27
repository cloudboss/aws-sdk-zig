pub const MetricType = enum {
    queries_by_count,
    queries_by_zero_click_rate,
    queries_by_zero_result_rate,
    docs_by_click_count,
    agg_query_doc_metrics,
    trend_query_doc_metrics,

    pub const json_field_names = .{
        .queries_by_count = "QUERIES_BY_COUNT",
        .queries_by_zero_click_rate = "QUERIES_BY_ZERO_CLICK_RATE",
        .queries_by_zero_result_rate = "QUERIES_BY_ZERO_RESULT_RATE",
        .docs_by_click_count = "DOCS_BY_CLICK_COUNT",
        .agg_query_doc_metrics = "AGG_QUERY_DOC_METRICS",
        .trend_query_doc_metrics = "TREND_QUERY_DOC_METRICS",
    };
};
