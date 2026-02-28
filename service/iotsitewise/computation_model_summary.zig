const ComputationModelStatus = @import("computation_model_status.zig").ComputationModelStatus;
const ComputationModelType = @import("computation_model_type.zig").ComputationModelType;

/// Contains a summary of a computation model.
pub const ComputationModelSummary = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the computation model, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:computation-model/${ComputationModelId}`
    arn: []const u8,

    /// The model creation date, in Unix epoch time.
    creation_date: i64,

    /// The description of the computation model.
    description: ?[]const u8,

    /// The ID of the computation model.
    id: []const u8,

    /// The time the model was last updated, in Unix epoch time.
    last_update_date: i64,

    /// The name of the computation model.
    name: []const u8,

    /// The current status of the computation model.
    status: ComputationModelStatus,

    /// The type of the computation model.
    @"type": ComputationModelType,

    /// The version of the computation model.
    version: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date = "creationDate",
        .description = "description",
        .id = "id",
        .last_update_date = "lastUpdateDate",
        .name = "name",
        .status = "status",
        .@"type" = "type",
        .version = "version",
    };
};
