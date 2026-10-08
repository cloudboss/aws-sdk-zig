const AttachPointType = @import("attach_point_type.zig").AttachPointType;

/// Describes a possible Attach Point for a Connection.
pub const AttachPointDescriptor = struct {
    /// The identifier for the specific type of the AttachPoint.
    identifier: []const u8,

    /// The descriptive name of the identifier attach point.
    name: []const u8,

    /// The type of this AttachPoint, which will dictate the syntax of the
    /// identifier.
    ///
    /// Current types include:
    ///
    /// * ARN
    /// * DirectConnect Gateway
    type: AttachPointType,

    pub const json_field_names = .{
        .identifier = "identifier",
        .name = "name",
        .type = "type",
    };
};
