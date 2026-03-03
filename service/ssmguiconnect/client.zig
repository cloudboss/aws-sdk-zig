const aws = @import("aws");
const std = @import("std");

const delete_connection_recording_preferences = @import("delete_connection_recording_preferences.zig");
const get_connection_recording_preferences = @import("get_connection_recording_preferences.zig");
const update_connection_recording_preferences = @import("update_connection_recording_preferences.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SSM GuiConnect";

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

    /// Deletes the preferences for recording RDP connections.
    pub fn deleteConnectionRecordingPreferences(self: *Self, allocator: std.mem.Allocator, input: delete_connection_recording_preferences.DeleteConnectionRecordingPreferencesInput, options: CallOptions) !delete_connection_recording_preferences.DeleteConnectionRecordingPreferencesOutput {
        return delete_connection_recording_preferences.execute(self, allocator, input, options);
    }

    /// Returns the preferences specified for recording RDP connections in the
    /// requesting Amazon Web Services account and Amazon Web Services Region.
    pub fn getConnectionRecordingPreferences(self: *Self, allocator: std.mem.Allocator, input: get_connection_recording_preferences.GetConnectionRecordingPreferencesInput, options: CallOptions) !get_connection_recording_preferences.GetConnectionRecordingPreferencesOutput {
        return get_connection_recording_preferences.execute(self, allocator, input, options);
    }

    /// Updates the preferences for recording RDP connections.
    pub fn updateConnectionRecordingPreferences(self: *Self, allocator: std.mem.Allocator, input: update_connection_recording_preferences.UpdateConnectionRecordingPreferencesInput, options: CallOptions) !update_connection_recording_preferences.UpdateConnectionRecordingPreferencesOutput {
        return update_connection_recording_preferences.execute(self, allocator, input, options);
    }
};
