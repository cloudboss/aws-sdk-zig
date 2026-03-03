pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const DeleteConnectionRecordingPreferencesInput = @import("delete_connection_recording_preferences.zig").DeleteConnectionRecordingPreferencesInput;
pub const DeleteConnectionRecordingPreferencesOutput = @import("delete_connection_recording_preferences.zig").DeleteConnectionRecordingPreferencesOutput;
pub const GetConnectionRecordingPreferencesOutput = @import("get_connection_recording_preferences.zig").GetConnectionRecordingPreferencesOutput;
pub const UpdateConnectionRecordingPreferencesInput = @import("update_connection_recording_preferences.zig").UpdateConnectionRecordingPreferencesInput;
pub const UpdateConnectionRecordingPreferencesOutput = @import("update_connection_recording_preferences.zig").UpdateConnectionRecordingPreferencesOutput;
