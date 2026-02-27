/// Use this parameter to configure client-side evaluation for your project.
/// Client-side evaluation allows your application to assign variations to user
/// sessions locally instead of by calling the
/// [EvaluateFeature](https://docs.aws.amazon.com/cloudwatchevidently/latest/APIReference/API_EvaluateFeature.html) operation to assign the variations. This mitigates the latency and availability risks that come with an API call.
///
/// `ProjectAppConfigResource` is a structure that defines the configuration of
/// how your application integrates with AppConfig to run client-side
/// evaluation.
pub const ProjectAppConfigResourceConfig = struct {
    /// The ID of the AppConfig application to use for client-side evaluation.
    application_id: ?[]const u8,

    /// The ID of the AppConfig environment to use for client-side evaluation. This
    /// must be an environment that is within the application that you specify for
    /// `applicationId`.
    environment_id: ?[]const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .environment_id = "environmentId",
    };
};
