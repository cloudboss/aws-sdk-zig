const IsolineAvoidanceAreaGeometry = @import("isoline_avoidance_area_geometry.zig").IsolineAvoidanceAreaGeometry;

/// The area to be avoided.
pub const IsolineAvoidanceArea = struct {
    /// Exceptions to the provided avoidance geometry, to be included while
    /// calculating an isoline.
    except: ?[]const IsolineAvoidanceAreaGeometry = null,

    /// Geometry of the area to be avoided.
    geometry: IsolineAvoidanceAreaGeometry,

    pub const json_field_names = .{
        .except = "Except",
        .geometry = "Geometry",
    };
};
