pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");

pub const delete_lexicon = @import("delete_lexicon.zig");
pub const describe_voices = @import("describe_voices.zig");
pub const get_lexicon = @import("get_lexicon.zig");
pub const get_speech_synthesis_task = @import("get_speech_synthesis_task.zig");
pub const list_lexicons = @import("list_lexicons.zig");
pub const list_speech_synthesis_tasks = @import("list_speech_synthesis_tasks.zig");
pub const put_lexicon = @import("put_lexicon.zig");
pub const start_speech_synthesis_task = @import("start_speech_synthesis_task.zig");
pub const synthesize_speech = @import("synthesize_speech.zig");
