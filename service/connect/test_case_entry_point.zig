const ChatEntryPointParameters = @import("chat_entry_point_parameters.zig").ChatEntryPointParameters;
const TestCaseEntryPointType = @import("test_case_entry_point_type.zig").TestCaseEntryPointType;
const VoiceCallEntryPointParameters = @import("voice_call_entry_point_parameters.zig").VoiceCallEntryPointParameters;

/// Defines the starting point for a test case.
pub const TestCaseEntryPoint = struct {
    /// Parameters for chat entry point.
    chat_entry_point_parameters: ?ChatEntryPointParameters = null,

    /// The type of entry point.
    @"type": ?TestCaseEntryPointType = null,

    /// Parameters for voice call entry point.
    voice_call_entry_point_parameters: ?VoiceCallEntryPointParameters = null,

    pub const json_field_names = .{
        .chat_entry_point_parameters = "ChatEntryPointParameters",
        .@"type" = "Type",
        .voice_call_entry_point_parameters = "VoiceCallEntryPointParameters",
    };
};
