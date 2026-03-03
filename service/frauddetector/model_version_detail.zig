const ExternalEventsDetail = @import("external_events_detail.zig").ExternalEventsDetail;
const IngestedEventsDetail = @import("ingested_events_detail.zig").IngestedEventsDetail;
const ModelTypeEnum = @import("model_type_enum.zig").ModelTypeEnum;
const TrainingDataSchema = @import("training_data_schema.zig").TrainingDataSchema;
const TrainingDataSourceEnum = @import("training_data_source_enum.zig").TrainingDataSourceEnum;
const TrainingResult = @import("training_result.zig").TrainingResult;
const TrainingResultV2 = @import("training_result_v2.zig").TrainingResultV2;

/// The details of the model version.
pub const ModelVersionDetail = struct {
    /// The model version ARN.
    arn: ?[]const u8 = null,

    /// The timestamp when the model was created.
    created_time: ?[]const u8 = null,

    /// The external events data details. This will be populated if the
    /// `trainingDataSource` for the model version is specified as
    /// `EXTERNAL_EVENTS`.
    external_events_detail: ?ExternalEventsDetail = null,

    /// The ingested events data details. This will be populated if the
    /// `trainingDataSource` for the model version is specified as
    /// `INGESTED_EVENTS`.
    ingested_events_detail: ?IngestedEventsDetail = null,

    /// The timestamp when the model was last updated.
    last_updated_time: ?[]const u8 = null,

    /// The model ID.
    model_id: ?[]const u8 = null,

    /// The model type.
    model_type: ?ModelTypeEnum = null,

    /// The model version number.
    model_version_number: ?[]const u8 = null,

    /// The status of the model version.
    status: ?[]const u8 = null,

    /// The training data schema.
    training_data_schema: ?TrainingDataSchema = null,

    /// The model version training data source.
    training_data_source: ?TrainingDataSourceEnum = null,

    /// The training results.
    training_result: ?TrainingResult = null,

    /// The training result details. The details include the relative importance of
    /// the variables.
    training_result_v2: ?TrainingResultV2 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .external_events_detail = "externalEventsDetail",
        .ingested_events_detail = "ingestedEventsDetail",
        .last_updated_time = "lastUpdatedTime",
        .model_id = "modelId",
        .model_type = "modelType",
        .model_version_number = "modelVersionNumber",
        .status = "status",
        .training_data_schema = "trainingDataSchema",
        .training_data_source = "trainingDataSource",
        .training_result = "trainingResult",
        .training_result_v2 = "trainingResultV2",
    };
};
