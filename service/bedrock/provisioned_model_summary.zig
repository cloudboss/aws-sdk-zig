const CommitmentDuration = @import("commitment_duration.zig").CommitmentDuration;
const ProvisionedModelStatus = @import("provisioned_model_status.zig").ProvisionedModelStatus;

/// A summary of information about a Provisioned Throughput.
///
/// This data type is used in the following API operations:
///
/// * [ListProvisionedThroughputs
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_ListProvisionedModelThroughputs.html#API_ListProvisionedModelThroughputs_ResponseSyntax)
pub const ProvisionedModelSummary = struct {
    /// The duration for which the Provisioned Throughput was committed.
    commitment_duration: ?CommitmentDuration,

    /// The timestamp for when the commitment term of the Provisioned Throughput
    /// expires.
    commitment_expiration_time: ?i64,

    /// The time that the Provisioned Throughput was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the model requested to be associated to
    /// this Provisioned Throughput. This value differs from the `modelArn` if
    /// updating hasn't completed.
    desired_model_arn: []const u8,

    /// The number of model units that was requested to be allocated to the
    /// Provisioned Throughput.
    desired_model_units: i32,

    /// The Amazon Resource Name (ARN) of the base model for which the Provisioned
    /// Throughput was created, or of the base model that the custom model for which
    /// the Provisioned Throughput was created was customized.
    foundation_model_arn: []const u8,

    /// The time that the Provisioned Throughput was last modified.
    last_modified_time: i64,

    /// The Amazon Resource Name (ARN) of the model associated with the Provisioned
    /// Throughput.
    model_arn: []const u8,

    /// The number of model units allocated to the Provisioned Throughput.
    model_units: i32,

    /// The Amazon Resource Name (ARN) of the Provisioned Throughput.
    provisioned_model_arn: []const u8,

    /// The name of the Provisioned Throughput.
    provisioned_model_name: []const u8,

    /// The status of the Provisioned Throughput.
    status: ProvisionedModelStatus,

    pub const json_field_names = .{
        .commitment_duration = "commitmentDuration",
        .commitment_expiration_time = "commitmentExpirationTime",
        .creation_time = "creationTime",
        .desired_model_arn = "desiredModelArn",
        .desired_model_units = "desiredModelUnits",
        .foundation_model_arn = "foundationModelArn",
        .last_modified_time = "lastModifiedTime",
        .model_arn = "modelArn",
        .model_units = "modelUnits",
        .provisioned_model_arn = "provisionedModelArn",
        .provisioned_model_name = "provisionedModelName",
        .status = "status",
    };
};
