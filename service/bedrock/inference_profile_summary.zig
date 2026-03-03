const InferenceProfileModel = @import("inference_profile_model.zig").InferenceProfileModel;
const InferenceProfileStatus = @import("inference_profile_status.zig").InferenceProfileStatus;
const InferenceProfileType = @import("inference_profile_type.zig").InferenceProfileType;

/// Contains information about an inference profile.
pub const InferenceProfileSummary = struct {
    /// The time at which the inference profile was created.
    created_at: ?i64 = null,

    /// The description of the inference profile.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the inference profile.
    inference_profile_arn: []const u8,

    /// The unique identifier of the inference profile.
    inference_profile_id: []const u8,

    /// The name of the inference profile.
    inference_profile_name: []const u8,

    /// A list of information about each model in the inference profile.
    models: []const InferenceProfileModel,

    /// The status of the inference profile. `ACTIVE` means that the inference
    /// profile is ready to be used.
    status: InferenceProfileStatus,

    /// The type of the inference profile. The following types are possible:
    ///
    /// * `SYSTEM_DEFINED` – The inference profile is defined by Amazon Bedrock. You
    ///   can route inference requests across regions with these inference profiles.
    /// * `APPLICATION` – The inference profile was created by a user. This type of
    ///   inference profile can track metrics and costs when invoking the model in
    ///   it. The inference profile may route requests to one or multiple regions.
    @"type": InferenceProfileType,

    /// The time at which the inference profile was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .inference_profile_arn = "inferenceProfileArn",
        .inference_profile_id = "inferenceProfileId",
        .inference_profile_name = "inferenceProfileName",
        .models = "models",
        .status = "status",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};
