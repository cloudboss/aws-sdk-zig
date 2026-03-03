const aws = @import("aws");
const std = @import("std");

const configure_logs_for_channel = @import("configure_logs_for_channel.zig");
const configure_logs_for_playback_configuration = @import("configure_logs_for_playback_configuration.zig");
const create_channel = @import("create_channel.zig");
const create_live_source = @import("create_live_source.zig");
const create_prefetch_schedule = @import("create_prefetch_schedule.zig");
const create_program = @import("create_program.zig");
const create_source_location = @import("create_source_location.zig");
const create_vod_source = @import("create_vod_source.zig");
const delete_channel = @import("delete_channel.zig");
const delete_channel_policy = @import("delete_channel_policy.zig");
const delete_live_source = @import("delete_live_source.zig");
const delete_playback_configuration = @import("delete_playback_configuration.zig");
const delete_prefetch_schedule = @import("delete_prefetch_schedule.zig");
const delete_program = @import("delete_program.zig");
const delete_source_location = @import("delete_source_location.zig");
const delete_vod_source = @import("delete_vod_source.zig");
const describe_channel = @import("describe_channel.zig");
const describe_live_source = @import("describe_live_source.zig");
const describe_program = @import("describe_program.zig");
const describe_source_location = @import("describe_source_location.zig");
const describe_vod_source = @import("describe_vod_source.zig");
const get_channel_policy = @import("get_channel_policy.zig");
const get_channel_schedule = @import("get_channel_schedule.zig");
const get_playback_configuration = @import("get_playback_configuration.zig");
const get_prefetch_schedule = @import("get_prefetch_schedule.zig");
const list_alerts = @import("list_alerts.zig");
const list_channels = @import("list_channels.zig");
const list_live_sources = @import("list_live_sources.zig");
const list_playback_configurations = @import("list_playback_configurations.zig");
const list_prefetch_schedules = @import("list_prefetch_schedules.zig");
const list_source_locations = @import("list_source_locations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_vod_sources = @import("list_vod_sources.zig");
const put_channel_policy = @import("put_channel_policy.zig");
const put_playback_configuration = @import("put_playback_configuration.zig");
const start_channel = @import("start_channel.zig");
const stop_channel = @import("stop_channel.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_channel = @import("update_channel.zig");
const update_live_source = @import("update_live_source.zig");
const update_program = @import("update_program.zig");
const update_source_location = @import("update_source_location.zig");
const update_vod_source = @import("update_vod_source.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MediaTailor";

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

    /// Configures Amazon CloudWatch log settings for a channel.
    pub fn configureLogsForChannel(self: *Self, allocator: std.mem.Allocator, input: configure_logs_for_channel.ConfigureLogsForChannelInput, options: configure_logs_for_channel.Options) !configure_logs_for_channel.ConfigureLogsForChannelOutput {
        return configure_logs_for_channel.execute(self, allocator, input, options);
    }

    /// Defines where AWS Elemental MediaTailor sends logs for the playback
    /// configuration.
    pub fn configureLogsForPlaybackConfiguration(self: *Self, allocator: std.mem.Allocator, input: configure_logs_for_playback_configuration.ConfigureLogsForPlaybackConfigurationInput, options: configure_logs_for_playback_configuration.Options) !configure_logs_for_playback_configuration.ConfigureLogsForPlaybackConfigurationOutput {
        return configure_logs_for_playback_configuration.execute(self, allocator, input, options);
    }

    /// Creates a channel. For information about MediaTailor channels, see [Working
    /// with
    /// channels](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-channels.html) in the *MediaTailor User Guide*.
    pub fn createChannel(self: *Self, allocator: std.mem.Allocator, input: create_channel.CreateChannelInput, options: create_channel.Options) !create_channel.CreateChannelOutput {
        return create_channel.execute(self, allocator, input, options);
    }

    /// The live source configuration.
    pub fn createLiveSource(self: *Self, allocator: std.mem.Allocator, input: create_live_source.CreateLiveSourceInput, options: create_live_source.Options) !create_live_source.CreateLiveSourceOutput {
        return create_live_source.execute(self, allocator, input, options);
    }

    /// Creates a prefetch schedule for a playback configuration. A prefetch
    /// schedule allows you to tell MediaTailor to fetch and prepare certain ads
    /// before an ad break happens. For more information about ad prefetching, see
    /// [Using ad
    /// prefetching](https://docs.aws.amazon.com/mediatailor/latest/ug/prefetching-ads.html) in the *MediaTailor User Guide*.
    pub fn createPrefetchSchedule(self: *Self, allocator: std.mem.Allocator, input: create_prefetch_schedule.CreatePrefetchScheduleInput, options: create_prefetch_schedule.Options) !create_prefetch_schedule.CreatePrefetchScheduleOutput {
        return create_prefetch_schedule.execute(self, allocator, input, options);
    }

    /// Creates a program within a channel. For information about programs, see
    /// [Working with
    /// programs](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-programs.html) in the *MediaTailor User Guide*.
    pub fn createProgram(self: *Self, allocator: std.mem.Allocator, input: create_program.CreateProgramInput, options: create_program.Options) !create_program.CreateProgramOutput {
        return create_program.execute(self, allocator, input, options);
    }

    /// Creates a source location. A source location is a container for sources. For
    /// more information about source locations, see [Working with source
    /// locations](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-source-locations.html) in the *MediaTailor User Guide*.
    pub fn createSourceLocation(self: *Self, allocator: std.mem.Allocator, input: create_source_location.CreateSourceLocationInput, options: create_source_location.Options) !create_source_location.CreateSourceLocationOutput {
        return create_source_location.execute(self, allocator, input, options);
    }

    /// The VOD source configuration parameters.
    pub fn createVodSource(self: *Self, allocator: std.mem.Allocator, input: create_vod_source.CreateVodSourceInput, options: create_vod_source.Options) !create_vod_source.CreateVodSourceOutput {
        return create_vod_source.execute(self, allocator, input, options);
    }

    /// Deletes a channel. For information about MediaTailor channels, see [Working
    /// with
    /// channels](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-channels.html) in the *MediaTailor User Guide*.
    pub fn deleteChannel(self: *Self, allocator: std.mem.Allocator, input: delete_channel.DeleteChannelInput, options: delete_channel.Options) !delete_channel.DeleteChannelOutput {
        return delete_channel.execute(self, allocator, input, options);
    }

    /// The channel policy to delete.
    pub fn deleteChannelPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_channel_policy.DeleteChannelPolicyInput, options: delete_channel_policy.Options) !delete_channel_policy.DeleteChannelPolicyOutput {
        return delete_channel_policy.execute(self, allocator, input, options);
    }

    /// The live source to delete.
    pub fn deleteLiveSource(self: *Self, allocator: std.mem.Allocator, input: delete_live_source.DeleteLiveSourceInput, options: delete_live_source.Options) !delete_live_source.DeleteLiveSourceOutput {
        return delete_live_source.execute(self, allocator, input, options);
    }

    /// Deletes a playback configuration. For information about MediaTailor
    /// configurations, see [Working with configurations in AWS Elemental
    /// MediaTailor](https://docs.aws.amazon.com/mediatailor/latest/ug/configurations.html).
    pub fn deletePlaybackConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_playback_configuration.DeletePlaybackConfigurationInput, options: delete_playback_configuration.Options) !delete_playback_configuration.DeletePlaybackConfigurationOutput {
        return delete_playback_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a prefetch schedule for a specific playback configuration. If you
    /// call `DeletePrefetchSchedule` on an expired prefetch schedule, MediaTailor
    /// returns an HTTP 404 status code. For more information about ad prefetching,
    /// see [Using ad
    /// prefetching](https://docs.aws.amazon.com/mediatailor/latest/ug/prefetching-ads.html) in the *MediaTailor User Guide*.
    pub fn deletePrefetchSchedule(self: *Self, allocator: std.mem.Allocator, input: delete_prefetch_schedule.DeletePrefetchScheduleInput, options: delete_prefetch_schedule.Options) !delete_prefetch_schedule.DeletePrefetchScheduleOutput {
        return delete_prefetch_schedule.execute(self, allocator, input, options);
    }

    /// Deletes a program within a channel. For information about programs, see
    /// [Working with
    /// programs](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-programs.html) in the *MediaTailor User Guide*.
    pub fn deleteProgram(self: *Self, allocator: std.mem.Allocator, input: delete_program.DeleteProgramInput, options: delete_program.Options) !delete_program.DeleteProgramOutput {
        return delete_program.execute(self, allocator, input, options);
    }

    /// Deletes a source location. A source location is a container for sources. For
    /// more information about source locations, see [Working with source
    /// locations](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-source-locations.html) in the *MediaTailor User Guide*.
    pub fn deleteSourceLocation(self: *Self, allocator: std.mem.Allocator, input: delete_source_location.DeleteSourceLocationInput, options: delete_source_location.Options) !delete_source_location.DeleteSourceLocationOutput {
        return delete_source_location.execute(self, allocator, input, options);
    }

    /// The video on demand (VOD) source to delete.
    pub fn deleteVodSource(self: *Self, allocator: std.mem.Allocator, input: delete_vod_source.DeleteVodSourceInput, options: delete_vod_source.Options) !delete_vod_source.DeleteVodSourceOutput {
        return delete_vod_source.execute(self, allocator, input, options);
    }

    /// Describes a channel. For information about MediaTailor channels, see
    /// [Working with
    /// channels](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-channels.html) in the *MediaTailor User Guide*.
    pub fn describeChannel(self: *Self, allocator: std.mem.Allocator, input: describe_channel.DescribeChannelInput, options: describe_channel.Options) !describe_channel.DescribeChannelOutput {
        return describe_channel.execute(self, allocator, input, options);
    }

    /// The live source to describe.
    pub fn describeLiveSource(self: *Self, allocator: std.mem.Allocator, input: describe_live_source.DescribeLiveSourceInput, options: describe_live_source.Options) !describe_live_source.DescribeLiveSourceOutput {
        return describe_live_source.execute(self, allocator, input, options);
    }

    /// Describes a program within a channel. For information about programs, see
    /// [Working with
    /// programs](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-programs.html) in the *MediaTailor User Guide*.
    pub fn describeProgram(self: *Self, allocator: std.mem.Allocator, input: describe_program.DescribeProgramInput, options: describe_program.Options) !describe_program.DescribeProgramOutput {
        return describe_program.execute(self, allocator, input, options);
    }

    /// Describes a source location. A source location is a container for sources.
    /// For more information about source locations, see [Working with source
    /// locations](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-source-locations.html) in the *MediaTailor User Guide*.
    pub fn describeSourceLocation(self: *Self, allocator: std.mem.Allocator, input: describe_source_location.DescribeSourceLocationInput, options: describe_source_location.Options) !describe_source_location.DescribeSourceLocationOutput {
        return describe_source_location.execute(self, allocator, input, options);
    }

    /// Provides details about a specific video on demand (VOD) source in a specific
    /// source location.
    pub fn describeVodSource(self: *Self, allocator: std.mem.Allocator, input: describe_vod_source.DescribeVodSourceInput, options: describe_vod_source.Options) !describe_vod_source.DescribeVodSourceOutput {
        return describe_vod_source.execute(self, allocator, input, options);
    }

    /// Returns the channel's IAM policy. IAM policies are used to control access to
    /// your channel.
    pub fn getChannelPolicy(self: *Self, allocator: std.mem.Allocator, input: get_channel_policy.GetChannelPolicyInput, options: get_channel_policy.Options) !get_channel_policy.GetChannelPolicyOutput {
        return get_channel_policy.execute(self, allocator, input, options);
    }

    /// Retrieves information about your channel's schedule.
    pub fn getChannelSchedule(self: *Self, allocator: std.mem.Allocator, input: get_channel_schedule.GetChannelScheduleInput, options: get_channel_schedule.Options) !get_channel_schedule.GetChannelScheduleOutput {
        return get_channel_schedule.execute(self, allocator, input, options);
    }

    /// Retrieves a playback configuration. For information about MediaTailor
    /// configurations, see [Working with configurations in AWS Elemental
    /// MediaTailor](https://docs.aws.amazon.com/mediatailor/latest/ug/configurations.html).
    pub fn getPlaybackConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_playback_configuration.GetPlaybackConfigurationInput, options: get_playback_configuration.Options) !get_playback_configuration.GetPlaybackConfigurationOutput {
        return get_playback_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves a prefetch schedule for a playback configuration. A prefetch
    /// schedule allows you to tell MediaTailor to fetch and prepare certain ads
    /// before an ad break happens. For more information about ad prefetching, see
    /// [Using ad
    /// prefetching](https://docs.aws.amazon.com/mediatailor/latest/ug/prefetching-ads.html) in the *MediaTailor User Guide*.
    pub fn getPrefetchSchedule(self: *Self, allocator: std.mem.Allocator, input: get_prefetch_schedule.GetPrefetchScheduleInput, options: get_prefetch_schedule.Options) !get_prefetch_schedule.GetPrefetchScheduleOutput {
        return get_prefetch_schedule.execute(self, allocator, input, options);
    }

    /// Lists the alerts that are associated with a MediaTailor channel assembly
    /// resource.
    pub fn listAlerts(self: *Self, allocator: std.mem.Allocator, input: list_alerts.ListAlertsInput, options: list_alerts.Options) !list_alerts.ListAlertsOutput {
        return list_alerts.execute(self, allocator, input, options);
    }

    /// Retrieves information about the channels that are associated with the
    /// current AWS account.
    pub fn listChannels(self: *Self, allocator: std.mem.Allocator, input: list_channels.ListChannelsInput, options: list_channels.Options) !list_channels.ListChannelsOutput {
        return list_channels.execute(self, allocator, input, options);
    }

    /// Lists the live sources contained in a source location. A source represents a
    /// piece of content.
    pub fn listLiveSources(self: *Self, allocator: std.mem.Allocator, input: list_live_sources.ListLiveSourcesInput, options: list_live_sources.Options) !list_live_sources.ListLiveSourcesOutput {
        return list_live_sources.execute(self, allocator, input, options);
    }

    /// Retrieves existing playback configurations. For information about
    /// MediaTailor configurations, see [Working with Configurations in AWS
    /// Elemental
    /// MediaTailor](https://docs.aws.amazon.com/mediatailor/latest/ug/configurations.html).
    pub fn listPlaybackConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_playback_configurations.ListPlaybackConfigurationsInput, options: list_playback_configurations.Options) !list_playback_configurations.ListPlaybackConfigurationsOutput {
        return list_playback_configurations.execute(self, allocator, input, options);
    }

    /// Lists the prefetch schedules for a playback configuration.
    pub fn listPrefetchSchedules(self: *Self, allocator: std.mem.Allocator, input: list_prefetch_schedules.ListPrefetchSchedulesInput, options: list_prefetch_schedules.Options) !list_prefetch_schedules.ListPrefetchSchedulesOutput {
        return list_prefetch_schedules.execute(self, allocator, input, options);
    }

    /// Lists the source locations for a channel. A source location defines the host
    /// server URL, and contains a list of sources.
    pub fn listSourceLocations(self: *Self, allocator: std.mem.Allocator, input: list_source_locations.ListSourceLocationsInput, options: list_source_locations.Options) !list_source_locations.ListSourceLocationsOutput {
        return list_source_locations.execute(self, allocator, input, options);
    }

    /// A list of tags that are associated with this resource. Tags are key-value
    /// pairs that you can associate with Amazon resources to help with
    /// organization, access control, and cost tracking. For more information, see
    /// [Tagging AWS Elemental MediaTailor
    /// Resources](https://docs.aws.amazon.com/mediatailor/latest/ug/tagging.html).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the VOD sources contained in a source location. A source represents a
    /// piece of content.
    pub fn listVodSources(self: *Self, allocator: std.mem.Allocator, input: list_vod_sources.ListVodSourcesInput, options: list_vod_sources.Options) !list_vod_sources.ListVodSourcesOutput {
        return list_vod_sources.execute(self, allocator, input, options);
    }

    /// Creates an IAM policy for the channel. IAM policies are used to control
    /// access to your channel.
    pub fn putChannelPolicy(self: *Self, allocator: std.mem.Allocator, input: put_channel_policy.PutChannelPolicyInput, options: put_channel_policy.Options) !put_channel_policy.PutChannelPolicyOutput {
        return put_channel_policy.execute(self, allocator, input, options);
    }

    /// Creates a playback configuration. For information about MediaTailor
    /// configurations, see [Working with configurations in AWS Elemental
    /// MediaTailor](https://docs.aws.amazon.com/mediatailor/latest/ug/configurations.html).
    pub fn putPlaybackConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_playback_configuration.PutPlaybackConfigurationInput, options: put_playback_configuration.Options) !put_playback_configuration.PutPlaybackConfigurationOutput {
        return put_playback_configuration.execute(self, allocator, input, options);
    }

    /// Starts a channel. For information about MediaTailor channels, see [Working
    /// with
    /// channels](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-channels.html) in the *MediaTailor User Guide*.
    pub fn startChannel(self: *Self, allocator: std.mem.Allocator, input: start_channel.StartChannelInput, options: start_channel.Options) !start_channel.StartChannelOutput {
        return start_channel.execute(self, allocator, input, options);
    }

    /// Stops a channel. For information about MediaTailor channels, see [Working
    /// with
    /// channels](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-channels.html) in the *MediaTailor User Guide*.
    pub fn stopChannel(self: *Self, allocator: std.mem.Allocator, input: stop_channel.StopChannelInput, options: stop_channel.Options) !stop_channel.StopChannelOutput {
        return stop_channel.execute(self, allocator, input, options);
    }

    /// The resource to tag. Tags are key-value pairs that you can associate with
    /// Amazon resources to help with organization, access control, and cost
    /// tracking. For more information, see [Tagging AWS Elemental MediaTailor
    /// Resources](https://docs.aws.amazon.com/mediatailor/latest/ug/tagging.html).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// The resource to untag.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a channel. For information about MediaTailor channels, see [Working
    /// with
    /// channels](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-channels.html) in the *MediaTailor User Guide*.
    pub fn updateChannel(self: *Self, allocator: std.mem.Allocator, input: update_channel.UpdateChannelInput, options: update_channel.Options) !update_channel.UpdateChannelOutput {
        return update_channel.execute(self, allocator, input, options);
    }

    /// Updates a live source's configuration.
    pub fn updateLiveSource(self: *Self, allocator: std.mem.Allocator, input: update_live_source.UpdateLiveSourceInput, options: update_live_source.Options) !update_live_source.UpdateLiveSourceOutput {
        return update_live_source.execute(self, allocator, input, options);
    }

    /// Updates a program within a channel.
    pub fn updateProgram(self: *Self, allocator: std.mem.Allocator, input: update_program.UpdateProgramInput, options: update_program.Options) !update_program.UpdateProgramOutput {
        return update_program.execute(self, allocator, input, options);
    }

    /// Updates a source location. A source location is a container for sources. For
    /// more information about source locations, see [Working with source
    /// locations](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-source-locations.html) in the *MediaTailor User Guide*.
    pub fn updateSourceLocation(self: *Self, allocator: std.mem.Allocator, input: update_source_location.UpdateSourceLocationInput, options: update_source_location.Options) !update_source_location.UpdateSourceLocationOutput {
        return update_source_location.execute(self, allocator, input, options);
    }

    /// Updates a VOD source's configuration.
    pub fn updateVodSource(self: *Self, allocator: std.mem.Allocator, input: update_vod_source.UpdateVodSourceInput, options: update_vod_source.Options) !update_vod_source.UpdateVodSourceOutput {
        return update_vod_source.execute(self, allocator, input, options);
    }

    pub fn getChannelSchedulePaginator(self: *Self, params: get_channel_schedule.GetChannelScheduleInput) paginator.GetChannelSchedulePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAlertsPaginator(self: *Self, params: list_alerts.ListAlertsInput) paginator.ListAlertsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChannelsPaginator(self: *Self, params: list_channels.ListChannelsInput) paginator.ListChannelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLiveSourcesPaginator(self: *Self, params: list_live_sources.ListLiveSourcesInput) paginator.ListLiveSourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPlaybackConfigurationsPaginator(self: *Self, params: list_playback_configurations.ListPlaybackConfigurationsInput) paginator.ListPlaybackConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPrefetchSchedulesPaginator(self: *Self, params: list_prefetch_schedules.ListPrefetchSchedulesInput) paginator.ListPrefetchSchedulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSourceLocationsPaginator(self: *Self, params: list_source_locations.ListSourceLocationsInput) paginator.ListSourceLocationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVodSourcesPaginator(self: *Self, params: list_vod_sources.ListVodSourcesInput) paginator.ListVodSourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
