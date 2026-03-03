const DestinationInfo = @import("destination_info.zig").DestinationInfo;
const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const ResourceType = @import("resource_type.zig").ResourceType;
const CloudFormationStackRecordSourceInfo = @import("cloud_formation_stack_record_source_info.zig").CloudFormationStackRecordSourceInfo;
const RecordState = @import("record_state.zig").RecordState;

/// Describes a CloudFormation stack record created as a result of the `create
/// cloud
/// formation stack` action.
///
/// A CloudFormation stack record provides information about the AWS
/// CloudFormation stack used to
/// create a new Amazon Elastic Compute Cloud instance from an exported
/// Lightsail instance snapshot.
pub const CloudFormationStackRecord = struct {
    /// The Amazon Resource Name (ARN) of the CloudFormation stack record.
    arn: ?[]const u8 = null,

    /// The date when the CloudFormation stack record was created.
    created_at: ?i64 = null,

    /// A list of objects describing the destination service, which is AWS
    /// CloudFormation, and the Amazon
    /// Resource Name (ARN) of the AWS CloudFormation stack.
    destination_info: ?DestinationInfo = null,

    /// A list of objects describing the Availability Zone and Amazon Web Services
    /// Region of the
    /// CloudFormation stack record.
    location: ?ResourceLocation = null,

    /// The name of the CloudFormation stack record. It starts with
    /// `CloudFormationStackRecord` followed by a GUID.
    name: ?[]const u8 = null,

    /// The Lightsail resource type (`CloudFormationStackRecord`).
    resource_type: ?ResourceType = null,

    /// A list of objects describing the source of the CloudFormation stack record.
    source_info: ?[]const CloudFormationStackRecordSourceInfo = null,

    /// The current state of the CloudFormation stack record.
    state: ?RecordState = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .destination_info = "destinationInfo",
        .location = "location",
        .name = "name",
        .resource_type = "resourceType",
        .source_info = "sourceInfo",
        .state = "state",
    };
};
