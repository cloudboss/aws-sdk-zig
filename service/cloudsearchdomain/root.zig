pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const SearchInput = @import("search.zig").SearchInput;
pub const SearchOutput = @import("search.zig").SearchOutput;
pub const SuggestInput = @import("suggest.zig").SuggestInput;
pub const SuggestOutput = @import("suggest.zig").SuggestOutput;
pub const UploadDocumentsInput = @import("upload_documents.zig").UploadDocumentsInput;
pub const UploadDocumentsOutput = @import("upload_documents.zig").UploadDocumentsOutput;
