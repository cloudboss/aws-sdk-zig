const IsolineEngineType = @import("isoline_engine_type.zig").IsolineEngineType;
const IsolineHazardousCargoType = @import("isoline_hazardous_cargo_type.zig").IsolineHazardousCargoType;
const IsolineVehicleLicensePlate = @import("isoline_vehicle_license_plate.zig").IsolineVehicleLicensePlate;
const IsolineTrailerOptions = @import("isoline_trailer_options.zig").IsolineTrailerOptions;
const IsolineTruckType = @import("isoline_truck_type.zig").IsolineTruckType;
const WeightPerAxleGroup = @import("weight_per_axle_group.zig").WeightPerAxleGroup;

/// Vehicle characteristics and restrictions that affect which roads can be used
/// when calculating reachable areas for trucks. These details ensure that
/// routes respect physical limitations and legal requirements.
///
/// These apply when the provided travel mode is `Truck`
pub const IsolineTruckOptions = struct {
    /// The total number of axles on the vehicle. Required for certain road
    /// restrictions and weight limit calculations.
    axle_count: ?i32 = null,

    /// The type of engine powering the vehicle, which may affect route calculation
    /// due to road restrictions or vehicle characteristics.
    ///
    /// * `INTERNAL_COMBUSTION`—Standard gasoline or diesel engine.
    /// * `ELECTRIC`—Battery electric vehicle.
    /// * `PLUGIN_HYBRID`—Combination of electric and internal combustion engines
    ///   with plug-in charging capability.
    engine_type: ?IsolineEngineType = null,

    /// The gross vehicle weight (the maximum weight a vehicle can safely operate
    /// at, as specified by the manufacturer) in kilograms. Used to avoid roads with
    /// weight restrictions and ensure compliance with maximum allowed vehicle
    /// weight regulations.
    ///
    /// **Unit**: `kilograms`
    gross_weight: i64 = 0,

    /// Types of hazardous materials being transported. This affects which roads and
    /// tunnels can be used based on local regulations.
    ///
    /// * `Combustible`—Materials that can burn readily
    /// * `Corrosive`—Materials that can destroy or irreversibly damage other
    ///   substances
    /// * `Explosive`—Materials that can produce an explosion by chemical reaction
    /// * `Flammable`—Materials that can easily ignite
    /// * `Gas`—Hazardous materials in gaseous form
    /// * `HarmfulToWater`—Materials that pose a risk to water sources if released
    /// * `Organic`—Hazardous organic compounds
    /// * `Other`—Hazardous materials not covered by other categories
    /// * `Poison`—Toxic materials
    /// * `PoisonousInhalation`—Materials that are toxic when inhaled
    /// * `Radioactive`—Materials that emit ionizing radiation
    hazardous_cargos: ?[]const IsolineHazardousCargoType = null,

    /// The vehicle height in centimeters. Used to avoid routes with low bridges or
    /// other height restrictions.
    ///
    /// **Unit**: `centimeters`
    height: i64 = 0,

    /// The height in centimeters measured from the ground to the highest point
    /// above the first axle. Used for specific bridge and tunnel clearance
    /// restrictions.
    ///
    /// **Unit**: `centimeters`
    height_above_first_axle: i64 = 0,

    /// The kingpin to rear axle (KPRA) length in centimeters. Used to determine if
    /// the vehicle can safely navigate turns and intersections.
    ///
    /// **Unit**: `centimeters`
    kpra_length: i64 = 0,

    /// The total vehicle length in centimeters. Used to avoid roads with length
    /// restrictions and determine if the vehicle can safely navigate turns.
    ///
    /// **Unit**: `centimeters`
    length: i64 = 0,

    /// License plate information used in regions where road access or routing
    /// restrictions are based on license plate numbers.
    license_plate: ?IsolineVehicleLicensePlate = null,

    /// The maximum speed in kilometers per hour at which the vehicle can or is
    /// permitted to travel. This affects travel time calculations and may result in
    /// different reachable areas compared to using default speed limits. Value must
    /// be between 3.6 and 252 kilometers per hour.
    ///
    /// **Unit**: `kilometers per hour`
    max_speed: ?f64 = null,

    /// The number of occupants in the vehicle. This can affect route calculations
    /// by enabling the use of high-occupancy vehicle (HOV) lanes where minimum
    /// occupancy requirements are met.
    ///
    /// Default value: `1`
    occupancy: ?i32 = null,

    /// The maximum cargo weight in kilograms that the vehicle (including attached
    /// trailers) is rated to carry.
    ///
    /// **Unit**: `kilograms`
    payload_capacity: i64 = 0,

    /// The total number of tires on the vehicle.
    tire_count: ?i32 = null,

    /// Optional specifications for attached trailers. When provided, trailer
    /// characteristics affect route calculations to ensure compliance with
    /// trailer-specific restrictions such as length limits, weight distribution
    /// requirements, and access restrictions for multi-trailer configurations.
    trailer: ?IsolineTrailerOptions = null,

    /// The type of truck: `LightTruck` for smaller delivery vehicles, `
    /// StraightTruck ` for rigid body trucks, or `Tractor` for tractor-trailer
    /// combinations.
    truck_type: ?IsolineTruckType = null,

    /// The tunnel restriction code.
    ///
    /// Tunnel categories in this list indicate the restrictions which apply to
    /// certain tunnels in Great Britain. They relate to the types of dangerous
    /// goods that can be transported through them.
    ///
    /// * *Tunnel Category B*
    ///
    /// * *Risk Level*: Limited risk
    /// * *Restrictions*: Few restrictions
    ///
    /// * *Tunnel Category C*
    ///
    /// * *Risk Level*: Medium risk
    /// * *Restrictions*: Some restrictions
    ///
    /// * *Tunnel Category D*
    ///
    /// * *Risk Level*: High risk
    /// * *Restrictions*: Many restrictions occur
    ///
    /// * *Tunnel Category E*
    ///
    /// * *Risk Level*: Very high risk
    /// * *Restrictions*: Restricted tunnel
    tunnel_restriction_code: ?[]const u8 = null,

    /// The heaviest weight per axle in kilograms, regardless of axle type or
    /// grouping. Used for roads with axle-weight restrictions in regions where
    /// regulations don't distinguish between different axle configurations.
    ///
    /// **Unit**: `kilograms`
    weight_per_axle: i64 = 0,

    /// Specifies the total weight for different axle group configurations. Used in
    /// regions where regulations set different weight limits based on axle group
    /// types.
    ///
    /// **Unit**: `kilograms`
    weight_per_axle_group: ?WeightPerAxleGroup = null,

    /// The vehicle width in centimeters. Used to avoid routes with width
    /// restrictions.
    ///
    /// **Unit**: `centimeters`
    width: i64 = 0,

    pub const json_field_names = .{
        .axle_count = "AxleCount",
        .engine_type = "EngineType",
        .gross_weight = "GrossWeight",
        .hazardous_cargos = "HazardousCargos",
        .height = "Height",
        .height_above_first_axle = "HeightAboveFirstAxle",
        .kpra_length = "KpraLength",
        .length = "Length",
        .license_plate = "LicensePlate",
        .max_speed = "MaxSpeed",
        .occupancy = "Occupancy",
        .payload_capacity = "PayloadCapacity",
        .tire_count = "TireCount",
        .trailer = "Trailer",
        .truck_type = "TruckType",
        .tunnel_restriction_code = "TunnelRestrictionCode",
        .weight_per_axle = "WeightPerAxle",
        .weight_per_axle_group = "WeightPerAxleGroup",
        .width = "Width",
    };
};
