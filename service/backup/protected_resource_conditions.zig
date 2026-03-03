const KeyValue = @import("key_value.zig").KeyValue;

/// The conditions that you define for resources in
/// your restore testing plan using tags.
pub const ProtectedResourceConditions = struct {
    /// Filters the values of your tagged resources for only
    /// those resources that you tagged with the same value.
    /// Also called "exact matching."
    string_equals: ?[]const KeyValue = null,

    /// Filters the values of your tagged resources for only
    /// those resources that you tagged that do not have the same value.
    /// Also called "negated matching."
    string_not_equals: ?[]const KeyValue = null,

    pub const json_field_names = .{
        .string_equals = "StringEquals",
        .string_not_equals = "StringNotEquals",
    };
};
