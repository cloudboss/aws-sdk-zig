const Permit = @import("permit.zig").Permit;
const SigningKeyInfo = @import("signing_key_info.zig").SigningKeyInfo;
const SupportPermitStatus = @import("support_permit_status.zig").SupportPermitStatus;

/// A summary of a support permit.
pub const SupportPermitSummary = struct {
    /// The ARN of the support permit.
    arn: []const u8,

    /// The timestamp when the permit was created.
    created_at: i64,

    /// The name of the support permit.
    name: []const u8,

    /// The permit definition.
    permit: Permit,

    /// The signing key information for the permit.
    signing_key_info: SigningKeyInfo,

    /// The current status of the support permit.
    status: SupportPermitStatus,

    /// The display identifier of the support case associated with the permit.
    support_case_display_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .name = "name",
        .permit = "permit",
        .signing_key_info = "signingKeyInfo",
        .status = "status",
        .support_case_display_id = "supportCaseDisplayId",
    };
};
