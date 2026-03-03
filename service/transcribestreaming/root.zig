pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const GetMedicalScribeStreamInput = @import("get_medical_scribe_stream.zig").GetMedicalScribeStreamInput;
pub const GetMedicalScribeStreamOutput = @import("get_medical_scribe_stream.zig").GetMedicalScribeStreamOutput;
pub const StartCallAnalyticsStreamTranscriptionInput = @import("start_call_analytics_stream_transcription.zig").StartCallAnalyticsStreamTranscriptionInput;
pub const StartCallAnalyticsStreamTranscriptionOutput = @import("start_call_analytics_stream_transcription.zig").StartCallAnalyticsStreamTranscriptionOutput;
pub const StartMedicalScribeStreamInput = @import("start_medical_scribe_stream.zig").StartMedicalScribeStreamInput;
pub const StartMedicalScribeStreamOutput = @import("start_medical_scribe_stream.zig").StartMedicalScribeStreamOutput;
pub const StartMedicalStreamTranscriptionInput = @import("start_medical_stream_transcription.zig").StartMedicalStreamTranscriptionInput;
pub const StartMedicalStreamTranscriptionOutput = @import("start_medical_stream_transcription.zig").StartMedicalStreamTranscriptionOutput;
pub const StartStreamTranscriptionInput = @import("start_stream_transcription.zig").StartStreamTranscriptionInput;
pub const StartStreamTranscriptionOutput = @import("start_stream_transcription.zig").StartStreamTranscriptionOutput;
