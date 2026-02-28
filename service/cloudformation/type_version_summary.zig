const RegistryType = @import("registry_type.zig").RegistryType;

/// Contains summary information about a specific version of a CloudFormation
/// extension.
pub const TypeVersionSummary = struct {
    /// The ARN of the extension version.
    arn: ?[]const u8,

    /// The description of the extension version.
    description: ?[]const u8,

    /// Whether the specified extension version is set as the default version.
    ///
    /// This applies only to private extensions you have registered in your account,
    /// and extensions
    /// published by Amazon. For public third-party extensions, CloudFormation
    /// returns
    /// `null`.
    is_default_version: ?bool,

    /// For public extensions that have been activated for this account and Region,
    /// the version of
    /// the public extension to be used for CloudFormation operations in this
    /// account and Region. For any
    /// extensions other than activated third-party extensions, CloudFormation
    /// returns
    /// `null`.
    ///
    /// How you specified `AutoUpdate` when enabling the extension affects whether
    /// CloudFormation automatically updates the extension in this account and
    /// Region when a new version is
    /// released. For more information, see [Automatically use new versions of
    /// extensions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry-public.html#registry-public-enable-auto) in the
    /// *CloudFormation User Guide*.
    public_version_number: ?[]const u8,

    /// When the version was registered.
    time_created: ?i64,

    /// The kind of extension.
    type: ?RegistryType,

    /// The name of the extension.
    type_name: ?[]const u8,

    /// The ID of a specific version of the extension. The version ID is the value
    /// at the end of the
    /// ARN assigned to the extension version when it's registered.
    version_id: ?[]const u8,
};
