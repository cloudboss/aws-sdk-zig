const DomainStatus = @import("domain_status.zig").DomainStatus;

/// The domain's details.
pub const DomainDetails = struct {
    /// The creation time.
    creation_time: ?i64 = null,

    /// The domain's Amazon Resource Name (ARN).
    domain_arn: ?[]const u8 = null,

    /// The domain ID.
    domain_id: ?[]const u8 = null,

    /// The domain name.
    domain_name: ?[]const u8 = null,

    /// The last modified time.
    last_modified_time: ?i64 = null,

    /// The status.
    status: ?DomainStatus = null,

    /// The domain's URL.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .domain_arn = "DomainArn",
        .domain_id = "DomainId",
        .domain_name = "DomainName",
        .last_modified_time = "LastModifiedTime",
        .status = "Status",
        .url = "Url",
    };
};
