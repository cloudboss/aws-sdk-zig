pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const assume_role = @import("assume_role.zig");
pub const assume_role_with_saml = @import("assume_role_with_saml.zig");
pub const assume_role_with_web_identity = @import("assume_role_with_web_identity.zig");
pub const assume_root = @import("assume_root.zig");
pub const decode_authorization_message = @import("decode_authorization_message.zig");
pub const get_access_key_info = @import("get_access_key_info.zig");
pub const get_caller_identity = @import("get_caller_identity.zig");
pub const get_delegated_access_token = @import("get_delegated_access_token.zig");
pub const get_federation_token = @import("get_federation_token.zig");
pub const get_session_token = @import("get_session_token.zig");
pub const get_web_identity_token = @import("get_web_identity_token.zig");
