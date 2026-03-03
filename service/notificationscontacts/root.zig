pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const activate_email_contact = @import("activate_email_contact.zig");
pub const create_email_contact = @import("create_email_contact.zig");
pub const delete_email_contact = @import("delete_email_contact.zig");
pub const get_email_contact = @import("get_email_contact.zig");
pub const list_email_contacts = @import("list_email_contacts.zig");
pub const list_tags_for_resource = @import("list_tags_for_resource.zig");
pub const send_activation_code = @import("send_activation_code.zig");
pub const tag_resource = @import("tag_resource.zig");
pub const untag_resource = @import("untag_resource.zig");
