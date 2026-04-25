const IsolineAvoidanceAreaGeometry = @import("isoline_avoidance_area_geometry.zig").IsolineAvoidanceAreaGeometry;

/// Defines an area to avoid when calculating routes. Consists of a primary
/// geometry to avoid, with the ability to specify exception areas within that
/// geometry where travel is permitted.
pub const IsolineAvoidanceArea = struct {
    /// Areas within the primary avoidance geometry where travel is allowed. For
    /// example, you might want to avoid a neighborhood but allow travel on a major
    /// road that passes through it.
    except: ?[]const IsolineAvoidanceAreaGeometry = null,

    /// The primary area to avoid, specified using a bounding box, corridor,
    /// polygon, or polyline corridor.
    geometry: IsolineAvoidanceAreaGeometry,

    pub const json_field_names = .{
        .except = "Except",
        .geometry = "Geometry",
    };
};
