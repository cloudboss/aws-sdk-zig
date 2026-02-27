pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;

pub const get_medical_scribe_stream = @import("get_medical_scribe_stream.zig");
pub const start_call_analytics_stream_transcription = @import("start_call_analytics_stream_transcription.zig");
pub const start_medical_scribe_stream = @import("start_medical_scribe_stream.zig");
pub const start_medical_stream_transcription = @import("start_medical_stream_transcription.zig");
pub const start_stream_transcription = @import("start_stream_transcription.zig");
