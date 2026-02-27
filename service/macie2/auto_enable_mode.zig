/// Specifies whether to automatically enable automated sensitive data discovery
/// for accounts that are part of an organization in Amazon Macie. Valid values
/// are:
pub const AutoEnableMode = enum {
    all,
    new,
    none,

    pub const json_field_names = .{
        .all = "ALL",
        .new = "NEW",
        .none = "NONE",
    };
};
