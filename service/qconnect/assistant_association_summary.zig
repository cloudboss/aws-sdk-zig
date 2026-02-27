const aws = @import("aws");

const AssistantAssociationOutputData = @import("assistant_association_output_data.zig").AssistantAssociationOutputData;
const AssociationType = @import("association_type.zig").AssociationType;

/// Summary information about the assistant association.
pub const AssistantAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Q in Connect assistant.
    assistant_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the assistant association.
    assistant_association_arn: []const u8,

    /// The identifier of the assistant association.
    assistant_association_id: []const u8,

    /// The identifier of the Amazon Q in Connect assistant.
    assistant_id: []const u8,

    /// The association data.
    association_data: AssistantAssociationOutputData,

    /// The type of association.
    association_type: AssociationType,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .assistant_arn = "assistantArn",
        .assistant_association_arn = "assistantAssociationArn",
        .assistant_association_id = "assistantAssociationId",
        .assistant_id = "assistantId",
        .association_data = "associationData",
        .association_type = "associationType",
        .tags = "tags",
    };
};
