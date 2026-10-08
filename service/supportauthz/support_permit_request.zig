const Permit = @import("permit.zig").Permit;
const SupportPermitRequestStatus = @import("support_permit_request_status.zig").SupportPermitRequestStatus;

/// A permit request from an AWS support operator.
pub const SupportPermitRequest = struct {
    /// The timestamp when the request was created.
    created_at: i64,

    /// The permit definition requested by the operator.
    permit: Permit,

    /// The ARN of the permit request.
    request_arn: []const u8,

    /// The current status of the permit request.
    status: SupportPermitRequestStatus,

    /// The display identifier of the support case associated with the request.
    support_case_display_id: []const u8,

    /// The timestamp when the request was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .permit = "permit",
        .request_arn = "requestArn",
        .status = "status",
        .support_case_display_id = "supportCaseDisplayId",
        .updated_at = "updatedAt",
    };
};
