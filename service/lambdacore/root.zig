pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const CreateNetworkConnectorInput = @import("create_network_connector.zig").CreateNetworkConnectorInput;
pub const CreateNetworkConnectorOutput = @import("create_network_connector.zig").CreateNetworkConnectorOutput;
pub const DeleteNetworkConnectorInput = @import("delete_network_connector.zig").DeleteNetworkConnectorInput;
pub const DeleteNetworkConnectorOutput = @import("delete_network_connector.zig").DeleteNetworkConnectorOutput;
pub const GetNetworkConnectorInput = @import("get_network_connector.zig").GetNetworkConnectorInput;
pub const GetNetworkConnectorOutput = @import("get_network_connector.zig").GetNetworkConnectorOutput;
pub const ListNetworkConnectorsInput = @import("list_network_connectors.zig").ListNetworkConnectorsInput;
pub const ListNetworkConnectorsOutput = @import("list_network_connectors.zig").ListNetworkConnectorsOutput;
pub const UpdateNetworkConnectorInput = @import("update_network_connector.zig").UpdateNetworkConnectorInput;
pub const UpdateNetworkConnectorOutput = @import("update_network_connector.zig").UpdateNetworkConnectorOutput;
