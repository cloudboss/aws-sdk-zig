const RegistrationStatus = @import("registration_status.zig").RegistrationStatus;

/// Contains general information about a domain.
pub const DomainInfo = struct {
    /// The ARN of the domain.
    arn: ?[]const u8 = null,

    /// The description of the domain provided through RegisterDomain.
    description: ?[]const u8 = null,

    /// The name of the domain. This name is unique within the account.
    name: []const u8,

    /// The status of the domain:
    ///
    /// * `REGISTERED` – The domain is properly registered and available. You can
    ///   use this domain
    /// for registering types and creating new workflow executions.
    ///
    /// * `DEPRECATED` – The domain was deprecated using DeprecateDomain, but is
    /// still in use. You should not create new workflow executions in this domain.
    status: RegistrationStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .description = "description",
        .name = "name",
        .status = "status",
    };
};
