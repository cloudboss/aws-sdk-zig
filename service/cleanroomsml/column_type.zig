pub const ColumnType = enum {
    user_id,
    item_id,
    timestamp,
    categorical_feature,
    numerical_feature,

    pub const json_field_names = .{
        .user_id = "USER_ID",
        .item_id = "ITEM_ID",
        .timestamp = "TIMESTAMP",
        .categorical_feature = "CATEGORICAL_FEATURE",
        .numerical_feature = "NUMERICAL_FEATURE",
    };
};
