const WhatIfPointScenario = @import("what_if_point_scenario.zig").WhatIfPointScenario;
const WhatIfRangeScenario = @import("what_if_range_scenario.zig").WhatIfRangeScenario;

/// The forecast scenario of a forecast in the line chart.
pub const ForecastScenario = struct {
    /// The what-if analysis forecast setup with the target date.
    what_if_point_scenario: ?WhatIfPointScenario = null,

    /// The what-if analysis forecast setup with the date range.
    what_if_range_scenario: ?WhatIfRangeScenario = null,

    pub const json_field_names = .{
        .what_if_point_scenario = "WhatIfPointScenario",
        .what_if_range_scenario = "WhatIfRangeScenario",
    };
};
