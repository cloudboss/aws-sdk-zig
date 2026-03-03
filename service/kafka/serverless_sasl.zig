const Iam = @import("iam.zig").Iam;

/// Details for client authentication using SASL.
pub const ServerlessSasl = struct {
    /// Indicates whether IAM access control is enabled.
    iam: ?Iam = null,

    pub const json_field_names = .{
        .iam = "Iam",
    };
};
