pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const ListTagsForResourceInput = @import("list_tags_for_resource.zig").ListTagsForResourceInput;
pub const ListTagsForResourceOutput = @import("list_tags_for_resource.zig").ListTagsForResourceOutput;
pub const PutDeploymentParameterInput = @import("put_deployment_parameter.zig").PutDeploymentParameterInput;
pub const PutDeploymentParameterOutput = @import("put_deployment_parameter.zig").PutDeploymentParameterOutput;
pub const TagResourceInput = @import("tag_resource.zig").TagResourceInput;
pub const TagResourceOutput = @import("tag_resource.zig").TagResourceOutput;
pub const UntagResourceInput = @import("untag_resource.zig").UntagResourceInput;
pub const UntagResourceOutput = @import("untag_resource.zig").UntagResourceOutput;
