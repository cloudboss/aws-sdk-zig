/// Contains information about the module from which the resource was created,
/// if the resource
/// was created from a module included in the stack template.
///
/// For more information about modules, see [Create reusable resource
/// configurations
/// that can be included across templates with CloudFormation
/// modules](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/modules.html) in the
/// *CloudFormation User Guide*.
pub const ModuleInfo = struct {
    /// A concatenated list of the logical IDs of the module or modules that
    /// contains the resource.
    /// Modules are listed starting with the inner-most nested module, and separated
    /// by
    /// `/`.
    ///
    /// In the following example, the resource was created from a module, `moduleA`,
    /// that's nested inside a parent module, `moduleB`.
    ///
    /// `moduleA/moduleB`
    ///
    /// For more information, see [Reference module resources in
    /// CloudFormation
    /// templates](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/module-ref-resources.html) in the *CloudFormation User Guide*.
    logical_id_hierarchy: ?[]const u8,

    /// A concatenated list of the module type or types that contains the resource.
    /// Module types are
    /// listed starting with the inner-most nested module, and separated by `/`.
    ///
    /// In the following example, the resource was created from a module of type
    /// `AWS::First::Example::MODULE`, that's nested inside a parent module of type
    /// `AWS::Second::Example::MODULE`.
    ///
    /// `AWS::First::Example::MODULE/AWS::Second::Example::MODULE`
    type_hierarchy: ?[]const u8,
};
