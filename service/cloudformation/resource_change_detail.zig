const ChangeSource = @import("change_source.zig").ChangeSource;
const EvaluationType = @import("evaluation_type.zig").EvaluationType;
const ResourceTargetDefinition = @import("resource_target_definition.zig").ResourceTargetDefinition;

/// For a resource with `Modify` as the action, the `ResourceChange`
/// structure describes the changes CloudFormation will make to that resource.
pub const ResourceChangeDetail = struct {
    /// The identity of the entity that triggered this change. This entity is a
    /// member of the group
    /// that's specified by the `ChangeSource` field. For example, if you modified
    /// the value
    /// of the `KeyPairName` parameter, the `CausingEntity` is the name of the
    /// parameter (`KeyPairName`).
    ///
    /// If the `ChangeSource` value is `DirectModification`, no value is given
    /// for `CausingEntity`.
    causing_entity: ?[]const u8,

    /// The group to which the `CausingEntity` value belongs. There are five entity
    /// groups:
    ///
    /// * `ResourceReference` entities are `Ref` intrinsic functions that refer to
    /// resources in the template, such as `{ "Ref" : "MyEC2InstanceResource" }`.
    ///
    /// * `ParameterReference` entities are `Ref` intrinsic functions that get
    /// template parameter values, such as `{ "Ref" : "MyPasswordParameter" }`.
    ///
    /// * `ResourceAttribute` entities are `Fn::GetAtt` intrinsic functions that
    /// get resource attribute values, such as `{ "Fn::GetAtt" : [
    /// "MyEC2InstanceResource",
    /// "PublicDnsName" ] }`.
    ///
    /// * `DirectModification` entities are changes that are made directly to the
    /// template.
    ///
    /// * `Automatic` entities are `AWS::CloudFormation::Stack` resource types,
    /// which are also known as nested stacks. If you made no changes to the
    /// `AWS::CloudFormation::Stack` resource, CloudFormation sets the
    /// `ChangeSource` to `Automatic` because the nested stack's template might
    /// have changed. Changes to a nested stack's template aren't visible to
    /// CloudFormation until you run
    /// an update on the parent stack.
    ///
    /// * `NoModification` entities are changes made to the template that matches
    ///   the actual
    /// state of the resource.
    change_source: ?ChangeSource,

    /// Indicates whether CloudFormation can determine the target value, and whether
    /// the target value
    /// will change before you execute a change set.
    ///
    /// For `Static` evaluations, CloudFormation can determine that the target value
    /// will
    /// change, and its value. For example, if you directly modify the
    /// `InstanceType` property
    /// of an EC2 instance, CloudFormation knows that this property value will
    /// change, and its value, so this
    /// is a `Static` evaluation.
    ///
    /// For `Dynamic` evaluations, can't determine the target value because it
    /// depends on
    /// the result of an intrinsic function, such as a `Ref` or `Fn::GetAtt`
    /// intrinsic function, when the stack is updated. For example, if your template
    /// includes a reference
    /// to a resource that's conditionally recreated, the value of the reference
    /// (the physical ID of the
    /// resource) might change, depending on if the resource is recreated. If the
    /// resource is recreated,
    /// it will have a new physical ID, so all references to that resource will also
    /// be updated.
    evaluation: ?EvaluationType,

    /// A `ResourceTargetDefinition` structure that describes the field that
    /// CloudFormation
    /// will change and whether the resource will be recreated.
    target: ?ResourceTargetDefinition,
};
