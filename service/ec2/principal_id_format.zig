const IdFormat = @import("id_format.zig").IdFormat;

/// PrincipalIdFormat description
pub const PrincipalIdFormat = struct {
    /// PrincipalIdFormatARN description
    arn: ?[]const u8 = null,

    /// PrincipalIdFormatStatuses description
    statuses: ?[]const IdFormat = null,
};
