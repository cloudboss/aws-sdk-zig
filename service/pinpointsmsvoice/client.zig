const aws = @import("aws");
const std = @import("std");

const create_configuration_set = @import("create_configuration_set.zig");
const create_configuration_set_event_destination = @import("create_configuration_set_event_destination.zig");
const delete_configuration_set = @import("delete_configuration_set.zig");
const delete_configuration_set_event_destination = @import("delete_configuration_set_event_destination.zig");
const get_configuration_set_event_destinations = @import("get_configuration_set_event_destinations.zig");
const list_configuration_sets = @import("list_configuration_sets.zig");
const send_voice_message = @import("send_voice_message.zig");
const update_configuration_set_event_destination = @import("update_configuration_set_event_destination.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Pinpoint SMS Voice";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Create a new configuration set. After you create the configuration set, you
    /// can add one or more event destinations to it.
    pub fn createConfigurationSet(self: *Self, allocator: std.mem.Allocator, input: create_configuration_set.CreateConfigurationSetInput, options: create_configuration_set.Options) !create_configuration_set.CreateConfigurationSetOutput {
        return create_configuration_set.execute(self, allocator, input, options);
    }

    /// Create a new event destination in a configuration set.
    pub fn createConfigurationSetEventDestination(self: *Self, allocator: std.mem.Allocator, input: create_configuration_set_event_destination.CreateConfigurationSetEventDestinationInput, options: create_configuration_set_event_destination.Options) !create_configuration_set_event_destination.CreateConfigurationSetEventDestinationOutput {
        return create_configuration_set_event_destination.execute(self, allocator, input, options);
    }

    /// Deletes an existing configuration set.
    pub fn deleteConfigurationSet(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_set.DeleteConfigurationSetInput, options: delete_configuration_set.Options) !delete_configuration_set.DeleteConfigurationSetOutput {
        return delete_configuration_set.execute(self, allocator, input, options);
    }

    /// Deletes an event destination in a configuration set.
    pub fn deleteConfigurationSetEventDestination(self: *Self, allocator: std.mem.Allocator, input: delete_configuration_set_event_destination.DeleteConfigurationSetEventDestinationInput, options: delete_configuration_set_event_destination.Options) !delete_configuration_set_event_destination.DeleteConfigurationSetEventDestinationOutput {
        return delete_configuration_set_event_destination.execute(self, allocator, input, options);
    }

    /// Obtain information about an event destination, including the types of events
    /// it reports, the Amazon Resource Name (ARN) of the destination, and the name
    /// of the event destination.
    pub fn getConfigurationSetEventDestinations(self: *Self, allocator: std.mem.Allocator, input: get_configuration_set_event_destinations.GetConfigurationSetEventDestinationsInput, options: get_configuration_set_event_destinations.Options) !get_configuration_set_event_destinations.GetConfigurationSetEventDestinationsOutput {
        return get_configuration_set_event_destinations.execute(self, allocator, input, options);
    }

    /// List all of the configuration sets associated with your Amazon Pinpoint
    /// account in the current region.
    pub fn listConfigurationSets(self: *Self, allocator: std.mem.Allocator, input: list_configuration_sets.ListConfigurationSetsInput, options: list_configuration_sets.Options) !list_configuration_sets.ListConfigurationSetsOutput {
        return list_configuration_sets.execute(self, allocator, input, options);
    }

    /// Create a new voice message and send it to a recipient's phone number.
    pub fn sendVoiceMessage(self: *Self, allocator: std.mem.Allocator, input: send_voice_message.SendVoiceMessageInput, options: send_voice_message.Options) !send_voice_message.SendVoiceMessageOutput {
        return send_voice_message.execute(self, allocator, input, options);
    }

    /// Update an event destination in a configuration set. An event destination is
    /// a location that you publish information about your voice calls to. For
    /// example, you can log an event to an Amazon CloudWatch destination when a
    /// call fails.
    pub fn updateConfigurationSetEventDestination(self: *Self, allocator: std.mem.Allocator, input: update_configuration_set_event_destination.UpdateConfigurationSetEventDestinationInput, options: update_configuration_set_event_destination.Options) !update_configuration_set_event_destination.UpdateConfigurationSetEventDestinationOutput {
        return update_configuration_set_event_destination.execute(self, allocator, input, options);
    }
};
