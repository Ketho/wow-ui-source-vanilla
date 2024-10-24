local Input =
{
	Name = "Input",
	Type = "System",

	Functions =
	{
		{
			Name = "GetCursorDelta",
			Type = "Function",

			Returns =
			{
				{ Name = "deltaX", Type = "number", Nilable = false },
				{ Name = "deltaY", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetCursorPosition",
			Type = "Function",

			Returns =
			{
				{ Name = "posX", Type = "number", Nilable = false },
				{ Name = "posY", Type = "number", Nilable = false },
			},
		},
		{
			Name = "GetMouseFoci",
			Type = "Function",

			Returns =
			{
				{ Name = "region", Type = "table", InnerType = "ScriptRegion", Nilable = false },
			},
		},
	},

	Events =
	{
	},

	Tables =
	{
	},
};

APIDocumentation:AddDocumentationTable(Input);