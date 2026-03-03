const DomainStatus = @import("domain_status.zig").DomainStatus;

/// Information about a domain, including its name, Amazon Resource Name (ARN),
/// and status.
/// The
/// [ListDomains](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_ListDomains.html) operation returns a list of `DomainSummary`
/// objects.
pub const DomainSummary = struct {
    /// The ARN of the domain.
    arn: ?[]const u8 = null,

    /// A timestamp that contains the date and time the domain was created.
    created_time: ?i64 = null,

    /// The key used to encrypt the domain.
    encryption_key: ?[]const u8 = null,

    /// The name of the domain.
    name: ?[]const u8 = null,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    owner: ?[]const u8 = null,

    /// A string that contains the status of the domain.
    status: ?DomainStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .encryption_key = "encryptionKey",
        .name = "name",
        .owner = "owner",
        .status = "status",
    };
};
