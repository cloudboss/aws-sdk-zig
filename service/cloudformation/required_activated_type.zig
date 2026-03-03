/// For extensions that are modules, a public third-party extension that must be
/// activated in
/// your account in order for the module itself to be activated.
///
/// For more information, see [Requirements for activating third-party public
/// modules](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/module-versioning.html#requirements-for-modules) in the
/// *CloudFormation User Guide*.
pub const RequiredActivatedType = struct {
    /// The type name of the public extension.
    ///
    /// If you specified a `TypeNameAlias` when enabling the extension in this
    /// account
    /// and Region, CloudFormation treats that alias as the extension's type name
    /// within the account and
    /// Region, not the type name of the public extension. For more information, see
    /// [Use
    /// aliases to refer to
    /// extensions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry-public.html#registry-public-enable-alias) in the *CloudFormation User Guide*.
    original_type_name: ?[]const u8 = null,

    /// The publisher ID of the extension publisher.
    publisher_id: ?[]const u8 = null,

    /// A list of the major versions of the extension type that the macro supports.
    supported_major_versions: ?[]const i32 = null,

    /// An alias assigned to the public extension, in this account and Region. If
    /// you specify an
    /// alias for the extension, CloudFormation treats the alias as the extension
    /// type name within this
    /// account and Region. You must use the alias to refer to the extension in your
    /// templates, API
    /// calls, and CloudFormation console.
    type_name_alias: ?[]const u8 = null,
};
