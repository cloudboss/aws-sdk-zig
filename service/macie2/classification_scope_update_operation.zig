/// Specifies how to apply changes to the S3 bucket exclusion list defined by
/// the classification scope for an Amazon Macie account. Valid values are:
pub const ClassificationScopeUpdateOperation = enum {
    add,
    replace,
    remove,

    pub const json_field_names = .{
        .add = "ADD",
        .replace = "REPLACE",
        .remove = "REMOVE",
    };
};
