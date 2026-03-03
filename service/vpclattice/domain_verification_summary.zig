const aws = @import("aws");

const VerificationStatus = @import("verification_status.zig").VerificationStatus;
const TxtMethodConfig = @import("txt_method_config.zig").TxtMethodConfig;

/// Summary information about a domain verification.
pub const DomainVerificationSummary = struct {
    /// The Amazon Resource Name (ARN) of the domain verification.
    arn: []const u8,

    /// The date and time that the domain verification was created, in ISO-8601
    /// format.
    created_at: i64,

    /// The domain name being verified.
    domain_name: []const u8,

    /// The ID of the domain verification.
    id: []const u8,

    /// The date and time that the domain was last successfully verified, in
    /// ISO-8601 format.
    last_verified_time: ?i64 = null,

    /// The current status of the domain verification process.
    status: VerificationStatus,

    /// The tags associated with the domain verification.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The TXT record configuration used for domain verification.
    txt_method_config: ?TxtMethodConfig = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .domain_name = "domainName",
        .id = "id",
        .last_verified_time = "lastVerifiedTime",
        .status = "status",
        .tags = "tags",
        .txt_method_config = "txtMethodConfig",
    };
};
