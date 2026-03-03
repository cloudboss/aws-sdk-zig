const aws = @import("aws");
const std = @import("std");

const create_alarm_model = @import("create_alarm_model.zig");
const create_detector_model = @import("create_detector_model.zig");
const create_input = @import("create_input.zig");
const delete_alarm_model = @import("delete_alarm_model.zig");
const delete_detector_model = @import("delete_detector_model.zig");
const delete_input = @import("delete_input.zig");
const describe_alarm_model = @import("describe_alarm_model.zig");
const describe_detector_model = @import("describe_detector_model.zig");
const describe_detector_model_analysis = @import("describe_detector_model_analysis.zig");
const describe_input = @import("describe_input.zig");
const describe_logging_options = @import("describe_logging_options.zig");
const get_detector_model_analysis_results = @import("get_detector_model_analysis_results.zig");
const list_alarm_model_versions = @import("list_alarm_model_versions.zig");
const list_alarm_models = @import("list_alarm_models.zig");
const list_detector_model_versions = @import("list_detector_model_versions.zig");
const list_detector_models = @import("list_detector_models.zig");
const list_input_routings = @import("list_input_routings.zig");
const list_inputs = @import("list_inputs.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_logging_options = @import("put_logging_options.zig");
const start_detector_model_analysis = @import("start_detector_model_analysis.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_alarm_model = @import("update_alarm_model.zig");
const update_detector_model = @import("update_detector_model.zig");
const update_input = @import("update_input.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IoT Events";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates an alarm model to monitor an AWS IoT Events input attribute. You can
    /// use the alarm to get
    /// notified when the value is outside a specified range. For more information,
    /// see [Create an
    /// alarm
    /// model](https://docs.aws.amazon.com/iotevents/latest/developerguide/create-alarms.html) in the *AWS IoT Events Developer Guide*.
    pub fn createAlarmModel(self: *Self, allocator: std.mem.Allocator, input: create_alarm_model.CreateAlarmModelInput, options: create_alarm_model.Options) !create_alarm_model.CreateAlarmModelOutput {
        return create_alarm_model.execute(self, allocator, input, options);
    }

    /// Creates a detector model.
    pub fn createDetectorModel(self: *Self, allocator: std.mem.Allocator, input: create_detector_model.CreateDetectorModelInput, options: create_detector_model.Options) !create_detector_model.CreateDetectorModelOutput {
        return create_detector_model.execute(self, allocator, input, options);
    }

    /// Creates an input.
    pub fn createInput(self: *Self, allocator: std.mem.Allocator, input: create_input.CreateInputInput, options: create_input.Options) !create_input.CreateInputOutput {
        return create_input.execute(self, allocator, input, options);
    }

    /// Deletes an alarm model. Any alarm instances that were created based on this
    /// alarm model
    /// are also deleted. This action can't be undone.
    pub fn deleteAlarmModel(self: *Self, allocator: std.mem.Allocator, input: delete_alarm_model.DeleteAlarmModelInput, options: delete_alarm_model.Options) !delete_alarm_model.DeleteAlarmModelOutput {
        return delete_alarm_model.execute(self, allocator, input, options);
    }

    /// Deletes a detector model. Any active instances of the detector model are
    /// also
    /// deleted.
    pub fn deleteDetectorModel(self: *Self, allocator: std.mem.Allocator, input: delete_detector_model.DeleteDetectorModelInput, options: delete_detector_model.Options) !delete_detector_model.DeleteDetectorModelOutput {
        return delete_detector_model.execute(self, allocator, input, options);
    }

    /// Deletes an input.
    pub fn deleteInput(self: *Self, allocator: std.mem.Allocator, input: delete_input.DeleteInputInput, options: delete_input.Options) !delete_input.DeleteInputOutput {
        return delete_input.execute(self, allocator, input, options);
    }

    /// Retrieves information about an alarm model. If you don't specify a value for
    /// the
    /// `alarmModelVersion` parameter, the latest version is returned.
    pub fn describeAlarmModel(self: *Self, allocator: std.mem.Allocator, input: describe_alarm_model.DescribeAlarmModelInput, options: describe_alarm_model.Options) !describe_alarm_model.DescribeAlarmModelOutput {
        return describe_alarm_model.execute(self, allocator, input, options);
    }

    /// Describes a detector model. If the `version` parameter is not specified,
    /// information about the latest version is returned.
    pub fn describeDetectorModel(self: *Self, allocator: std.mem.Allocator, input: describe_detector_model.DescribeDetectorModelInput, options: describe_detector_model.Options) !describe_detector_model.DescribeDetectorModelOutput {
        return describe_detector_model.execute(self, allocator, input, options);
    }

    /// Retrieves runtime information about a detector model analysis.
    ///
    /// After AWS IoT Events starts analyzing your detector model, you have up to 24
    /// hours to retrieve the analysis results.
    pub fn describeDetectorModelAnalysis(self: *Self, allocator: std.mem.Allocator, input: describe_detector_model_analysis.DescribeDetectorModelAnalysisInput, options: describe_detector_model_analysis.Options) !describe_detector_model_analysis.DescribeDetectorModelAnalysisOutput {
        return describe_detector_model_analysis.execute(self, allocator, input, options);
    }

    /// Describes an input.
    pub fn describeInput(self: *Self, allocator: std.mem.Allocator, input: describe_input.DescribeInputInput, options: describe_input.Options) !describe_input.DescribeInputOutput {
        return describe_input.execute(self, allocator, input, options);
    }

    /// Retrieves the current settings of the AWS IoT Events logging options.
    pub fn describeLoggingOptions(self: *Self, allocator: std.mem.Allocator, input: describe_logging_options.DescribeLoggingOptionsInput, options: describe_logging_options.Options) !describe_logging_options.DescribeLoggingOptionsOutput {
        return describe_logging_options.execute(self, allocator, input, options);
    }

    /// Retrieves one or more analysis results of the detector model.
    ///
    /// After AWS IoT Events starts analyzing your detector model, you have up to 24
    /// hours to retrieve the analysis results.
    pub fn getDetectorModelAnalysisResults(self: *Self, allocator: std.mem.Allocator, input: get_detector_model_analysis_results.GetDetectorModelAnalysisResultsInput, options: get_detector_model_analysis_results.Options) !get_detector_model_analysis_results.GetDetectorModelAnalysisResultsOutput {
        return get_detector_model_analysis_results.execute(self, allocator, input, options);
    }

    /// Lists all the versions of an alarm model. The operation returns only the
    /// metadata
    /// associated with each alarm model version.
    pub fn listAlarmModelVersions(self: *Self, allocator: std.mem.Allocator, input: list_alarm_model_versions.ListAlarmModelVersionsInput, options: list_alarm_model_versions.Options) !list_alarm_model_versions.ListAlarmModelVersionsOutput {
        return list_alarm_model_versions.execute(self, allocator, input, options);
    }

    /// Lists the alarm models that you created. The operation returns only the
    /// metadata
    /// associated with each alarm model.
    pub fn listAlarmModels(self: *Self, allocator: std.mem.Allocator, input: list_alarm_models.ListAlarmModelsInput, options: list_alarm_models.Options) !list_alarm_models.ListAlarmModelsOutput {
        return list_alarm_models.execute(self, allocator, input, options);
    }

    /// Lists all the versions of a detector model. Only the metadata associated
    /// with each
    /// detector model version is returned.
    pub fn listDetectorModelVersions(self: *Self, allocator: std.mem.Allocator, input: list_detector_model_versions.ListDetectorModelVersionsInput, options: list_detector_model_versions.Options) !list_detector_model_versions.ListDetectorModelVersionsOutput {
        return list_detector_model_versions.execute(self, allocator, input, options);
    }

    /// Lists the detector models you have created. Only the metadata associated
    /// with each
    /// detector model is returned.
    pub fn listDetectorModels(self: *Self, allocator: std.mem.Allocator, input: list_detector_models.ListDetectorModelsInput, options: list_detector_models.Options) !list_detector_models.ListDetectorModelsOutput {
        return list_detector_models.execute(self, allocator, input, options);
    }

    /// Lists one or more input routings.
    pub fn listInputRoutings(self: *Self, allocator: std.mem.Allocator, input: list_input_routings.ListInputRoutingsInput, options: list_input_routings.Options) !list_input_routings.ListInputRoutingsOutput {
        return list_input_routings.execute(self, allocator, input, options);
    }

    /// Lists the inputs you have created.
    pub fn listInputs(self: *Self, allocator: std.mem.Allocator, input: list_inputs.ListInputsInput, options: list_inputs.Options) !list_inputs.ListInputsOutput {
        return list_inputs.execute(self, allocator, input, options);
    }

    /// Lists the tags (metadata) you have assigned to the resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Sets or updates the AWS IoT Events logging options.
    ///
    /// If you update the value of any `loggingOptions` field, it takes up to one
    /// minute for the change to take effect. If you change the policy attached to
    /// the role you
    /// specified in the `roleArn` field (for example, to correct an invalid
    /// policy), it
    /// takes up to five minutes for that change to take effect.
    pub fn putLoggingOptions(self: *Self, allocator: std.mem.Allocator, input: put_logging_options.PutLoggingOptionsInput, options: put_logging_options.Options) !put_logging_options.PutLoggingOptionsOutput {
        return put_logging_options.execute(self, allocator, input, options);
    }

    /// Performs an analysis of your detector model. For more information,
    /// see [Troubleshooting a detector
    /// model](https://docs.aws.amazon.com/iotevents/latest/developerguide/iotevents-analyze-api.html)
    /// in the *AWS IoT Events Developer Guide*.
    pub fn startDetectorModelAnalysis(self: *Self, allocator: std.mem.Allocator, input: start_detector_model_analysis.StartDetectorModelAnalysisInput, options: start_detector_model_analysis.Options) !start_detector_model_analysis.StartDetectorModelAnalysisOutput {
        return start_detector_model_analysis.execute(self, allocator, input, options);
    }

    /// Adds to or modifies the tags of the given resource. Tags are metadata that
    /// can be used to
    /// manage a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the given tags (metadata) from the resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an alarm model. Any alarms that were created based on the previous
    /// version are
    /// deleted and then created again as new data arrives.
    pub fn updateAlarmModel(self: *Self, allocator: std.mem.Allocator, input: update_alarm_model.UpdateAlarmModelInput, options: update_alarm_model.Options) !update_alarm_model.UpdateAlarmModelOutput {
        return update_alarm_model.execute(self, allocator, input, options);
    }

    /// Updates a detector model. Detectors (instances) spawned by the previous
    /// version are
    /// deleted and then re-created as new inputs arrive.
    pub fn updateDetectorModel(self: *Self, allocator: std.mem.Allocator, input: update_detector_model.UpdateDetectorModelInput, options: update_detector_model.Options) !update_detector_model.UpdateDetectorModelOutput {
        return update_detector_model.execute(self, allocator, input, options);
    }

    /// Updates an input.
    pub fn updateInput(self: *Self, allocator: std.mem.Allocator, input: update_input.UpdateInputInput, options: update_input.Options) !update_input.UpdateInputOutput {
        return update_input.execute(self, allocator, input, options);
    }
};
