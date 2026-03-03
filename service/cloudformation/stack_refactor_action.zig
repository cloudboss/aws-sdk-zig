const StackRefactorActionType = @import("stack_refactor_action_type.zig").StackRefactorActionType;
const StackRefactorDetection = @import("stack_refactor_detection.zig").StackRefactorDetection;
const StackRefactorActionEntity = @import("stack_refactor_action_entity.zig").StackRefactorActionEntity;
const ResourceMapping = @import("resource_mapping.zig").ResourceMapping;
const Tag = @import("tag.zig").Tag;

/// Describes the stack and the action that CloudFormation will perform on it if
/// you execute the
/// stack refactor.
pub const StackRefactorAction = struct {
    /// The action that CloudFormation takes on the stack.
    action: ?StackRefactorActionType = null,

    /// A description to help you identify the refactor.
    description: ?[]const u8 = null,

    /// The detection type is one of the following:
    ///
    /// * Auto: CloudFormation figured out the mapping on its own.
    ///
    /// * Manual: The customer provided the mapping in the `ResourceMapping`
    /// parameter.
    detection: ?StackRefactorDetection = null,

    /// The description of the detection type.
    detection_reason: ?[]const u8 = null,

    /// The type that will be evaluated in the `StackRefactorAction`. The following
    /// are
    /// potential `Entity` types:
    ///
    /// * `Stack`
    ///
    /// * `Resource`
    entity: ?StackRefactorActionEntity = null,

    /// The name or unique identifier associated with the physical instance of the
    /// resource.
    physical_resource_id: ?[]const u8 = null,

    /// A key-value pair that identifies the target resource. The key is an
    /// identifier property (for
    /// example, `BucketName` for `AWS::S3::Bucket` resources) and the value is the
    /// actual property value (for example, `MyS3Bucket`).
    resource_identifier: ?[]const u8 = null,

    /// The mapping for the stack resource `Source` and stack resource
    /// `Destination`.
    resource_mapping: ?ResourceMapping = null,

    /// Assigns one or more tags to specified resources.
    tag_resources: ?[]const Tag = null,

    /// Removes one or more tags to specified resources.
    untag_resources: ?[]const []const u8 = null,
};
