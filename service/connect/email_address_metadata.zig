const AliasConfiguration = @import("alias_configuration.zig").AliasConfiguration;

/// Contains information about an email address for a contact center.
pub const EmailAddressMetadata = struct {
    /// A list of alias configurations for this email address, showing which email
    /// addresses forward to this primary
    /// address. Each configuration contains the email address ID of an alias that
    /// forwards emails to this address.
    alias_configurations: ?[]const AliasConfiguration,

    /// The description of the email address.
    description: ?[]const u8,

    /// The display name of email address.
    display_name: ?[]const u8,

    /// The email address, including the domain.
    email_address: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the email address.
    email_address_arn: ?[]const u8,

    /// The identifier of the email address.
    email_address_id: ?[]const u8,

    pub const json_field_names = .{
        .alias_configurations = "AliasConfigurations",
        .description = "Description",
        .display_name = "DisplayName",
        .email_address = "EmailAddress",
        .email_address_arn = "EmailAddressArn",
        .email_address_id = "EmailAddressId",
    };
};
