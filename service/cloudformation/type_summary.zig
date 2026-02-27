const IdentityProvider = @import("identity_provider.zig").IdentityProvider;
const RegistryType = @import("registry_type.zig").RegistryType;

/// Contains summary information about the specified CloudFormation extension.
pub const TypeSummary = struct {
    /// The ID of the default version of the extension. The default version is used
    /// when the
    /// extension version isn't specified.
    ///
    /// This applies only to private extensions you have registered in your account.
    /// For public
    /// extensions, both those provided by Amazon and published by third parties,
    /// CloudFormation returns
    /// `null`. For more information, see
    /// [RegisterType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_RegisterType.html).
    ///
    /// To set the default version of an extension, use SetTypeDefaultVersion.
    default_version_id: ?[]const u8,

    /// The description of the extension.
    description: ?[]const u8,

    /// Whether the extension is activated for this account and Region.
    ///
    /// This applies only to third-party public extensions. Extensions published by
    /// Amazon are
    /// activated by default.
    is_activated: ?bool,

    /// When the specified extension version was registered. This applies only to:
    ///
    /// * Private extensions you have registered in your account. For more
    ///   information, see
    ///   [RegisterType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_RegisterType.html).
    ///
    /// * Public extensions you have activated in your account with auto-update
    ///   specified. For more
    /// information, see
    /// [ActivateType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ActivateType.html).
    ///
    /// For all other extension types, CloudFormation returns `null`.
    last_updated: ?i64,

    /// For public extensions that have been activated for this account and Region,
    /// the latest
    /// version of the public extension *that is available*. For any extensions
    /// other
    /// than activated third-party extensions, CloudFormation returns `null`.
    ///
    /// How you specified `AutoUpdate` when enabling the extension affects whether
    /// CloudFormation automatically updates the extension in this account and
    /// Region when a new version is
    /// released. For more information, see [Automatically use new versions of
    /// extensions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry-public.html#registry-public-enable-auto) in the
    /// *CloudFormation User Guide*.
    latest_public_version: ?[]const u8,

    /// For public extensions that have been activated for this account and Region,
    /// the type name of
    /// the public extension.
    ///
    /// If you specified a `TypeNameAlias` when enabling the extension in this
    /// account
    /// and Region, CloudFormation treats that alias as the extension's type name
    /// within the account and
    /// Region, not the type name of the public extension. For more information, see
    /// [Use
    /// aliases to refer to
    /// extensions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry-public.html#registry-public-enable-alias) in the *CloudFormation User Guide*.
    original_type_name: ?[]const u8,

    /// For public extensions that have been activated for this account and Region,
    /// the version of
    /// the public extension to be used for CloudFormation operations in this
    /// account and Region.
    ///
    /// How you specified `AutoUpdate` when enabling the extension affects whether
    /// CloudFormation automatically updates the extension in this account and
    /// Region when a new version is
    /// released. For more information, see [Automatically use new versions of
    /// extensions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry-public.html#registry-public-enable-auto) in the
    /// *CloudFormation User Guide*.
    public_version_number: ?[]const u8,

    /// The ID of the extension publisher, if the extension is published by a third
    /// party.
    /// Extensions published by Amazon don't return a publisher ID.
    publisher_id: ?[]const u8,

    /// The service used to verify the publisher identity.
    ///
    /// For more information, see [Publishing extensions to make
    /// them available for public
    /// use](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/publish-extension.html) in the *CloudFormation Command Line Interface (CLI) User Guide*.
    publisher_identity: ?IdentityProvider,

    /// The publisher name, as defined in the public profile for that publisher in
    /// the service used
    /// to verify the publisher identity.
    publisher_name: ?[]const u8,

    /// The kind of extension.
    type: ?RegistryType,

    /// The ARN of the extension.
    type_arn: ?[]const u8,

    /// The name of the extension.
    ///
    /// If you specified a `TypeNameAlias` when you call the
    /// [ActivateType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ActivateType.html) API
    /// operation in your account and Region, CloudFormation considers that alias as
    /// the type name.
    type_name: ?[]const u8,
};
