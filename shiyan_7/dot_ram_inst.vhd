dot_ram_inst : dot_ram PORT MAP (
		data	 => data_sig,
		rdaddress	 => rdaddress_sig,
		rdclock	 => rdclock_sig,
		rden	 => rden_sig,
		wraddress	 => wraddress_sig,
		wrclock	 => wrclock_sig,
		wren	 => wren_sig,
		q	 => q_sig
	);
