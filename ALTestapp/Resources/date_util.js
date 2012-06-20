Date.prototype.getDayName = function(shortName) {
   var Days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
   if (shortName) {
      return Days[this.getDay()].substr(0,3);
   } else {
      return Days[this.getDay()];
   }
};

Date.prototype.getMonthName = function() {
   return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][this.getMonth()];
};

Date.prototype.shortString = function(shortDay, showYear) {
	var d = [this.getDayName(shortDay), this.getDate(), this.getMonthName(), this.getFullYear()];
	if (!showYear) {
		d.pop();
	}

	return d.join(' ');
};