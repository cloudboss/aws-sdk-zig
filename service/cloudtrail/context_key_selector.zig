const Type = @import("type.zig").Type;

/// An object that contains information types to be included in CloudTrail
/// enriched events.
pub const ContextKeySelector = struct {
    /// A list of keys defined by Type to be included in CloudTrail enriched events.
    equals: []const []const u8,

    /// Specifies the type of the event record field in ContextKeySelector. Valid
    /// values include RequestContext, TagContext.
    @"type": Type,

    pub const json_field_names = .{
        .equals = "Equals",
        .@"type" = "Type",
    };
};
