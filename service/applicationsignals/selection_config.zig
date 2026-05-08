const SelectionType = @import("selection_type.zig").SelectionType;

/// Defines how operations are selected for a service-level SLO.
pub const SelectionConfig = struct {
    /// A prefix string or regular expression that specifies which operations to
    /// include in a service-level SLO. When `SelectionType` is `PREFIX`, this value
    /// is a prefix string that matches the beginning of operation names. When
    /// `SelectionType` is `REGEX`, this value is a regular expression that matches
    /// operation names.
    pattern: ?[]const u8 = null,

    @"type": SelectionType,

    pub const json_field_names = .{
        .pattern = "Pattern",
        .@"type" = "Type",
    };
};
