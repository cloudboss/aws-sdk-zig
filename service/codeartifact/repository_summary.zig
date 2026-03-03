/// Details about a repository, including its Amazon Resource Name (ARN),
/// description, and
/// domain information. The
/// [ListRepositories](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_ListRepositories.html) operation returns a list of
/// `RepositorySummary` objects.
pub const RepositorySummary = struct {
    /// The Amazon Web Services account ID that manages the repository.
    administrator_account: ?[]const u8 = null,

    /// The ARN of the repository.
    arn: ?[]const u8 = null,

    /// A timestamp that represents the date and time the repository was created.
    created_time: ?i64 = null,

    /// The description of the repository.
    description: ?[]const u8 = null,

    /// The name of the domain that contains the repository.
    domain_name: ?[]const u8 = null,

    /// The 12-digit account number of the Amazon Web Services account that owns the
    /// domain. It does not include
    /// dashes or spaces.
    domain_owner: ?[]const u8 = null,

    /// The name of the repository.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .administrator_account = "administratorAccount",
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .domain_name = "domainName",
        .domain_owner = "domainOwner",
        .name = "name",
    };
};
