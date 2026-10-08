pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const paginator = @import("paginator.zig");
pub const types = @import("types.zig");

pub const GetEstimatedCarbonEmissionsDimensionValuesInput = @import("get_estimated_carbon_emissions_dimension_values.zig").GetEstimatedCarbonEmissionsDimensionValuesInput;
pub const GetEstimatedCarbonEmissionsDimensionValuesOutput = @import("get_estimated_carbon_emissions_dimension_values.zig").GetEstimatedCarbonEmissionsDimensionValuesOutput;
pub const GetEstimatedCarbonEmissionsInput = @import("get_estimated_carbon_emissions.zig").GetEstimatedCarbonEmissionsInput;
pub const GetEstimatedCarbonEmissionsOutput = @import("get_estimated_carbon_emissions.zig").GetEstimatedCarbonEmissionsOutput;
pub const GetEstimatedWaterAllocationDimensionValuesInput = @import("get_estimated_water_allocation_dimension_values.zig").GetEstimatedWaterAllocationDimensionValuesInput;
pub const GetEstimatedWaterAllocationDimensionValuesOutput = @import("get_estimated_water_allocation_dimension_values.zig").GetEstimatedWaterAllocationDimensionValuesOutput;
pub const GetEstimatedWaterAllocationInput = @import("get_estimated_water_allocation.zig").GetEstimatedWaterAllocationInput;
pub const GetEstimatedWaterAllocationOutput = @import("get_estimated_water_allocation.zig").GetEstimatedWaterAllocationOutput;
