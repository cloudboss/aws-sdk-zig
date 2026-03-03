const Iam = @import("iam.zig").Iam;
const Scram = @import("scram.zig").Scram;

/// Details for client authentication using SASL.
pub const Sasl = struct {
    /// Indicates whether IAM access control is enabled.
    iam: ?Iam = null,

    /// Details for SASL/SCRAM client authentication.
    scram: ?Scram = null,

    pub const json_field_names = .{
        .iam = "Iam",
        .scram = "Scram",
    };
};
