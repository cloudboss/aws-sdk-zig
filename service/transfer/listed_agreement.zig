const AgreementStatusType = @import("agreement_status_type.zig").AgreementStatusType;

/// Describes the properties of an agreement.
pub const ListedAgreement = struct {
    /// A unique identifier for the agreement. This identifier is returned when you
    /// create an agreement.
    agreement_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the specified agreement.
    arn: ?[]const u8,

    /// The current description for the agreement. You can change it by calling the
    /// `UpdateAgreement` operation and providing a new description.
    description: ?[]const u8,

    /// A unique identifier for the AS2 local profile.
    local_profile_id: ?[]const u8,

    /// A unique identifier for the partner profile.
    partner_profile_id: ?[]const u8,

    /// The unique identifier for the agreement.
    server_id: ?[]const u8,

    /// The agreement can be either `ACTIVE` or `INACTIVE`.
    status: ?AgreementStatusType,

    pub const json_field_names = .{
        .agreement_id = "AgreementId",
        .arn = "Arn",
        .description = "Description",
        .local_profile_id = "LocalProfileId",
        .partner_profile_id = "PartnerProfileId",
        .server_id = "ServerId",
        .status = "Status",
    };
};
