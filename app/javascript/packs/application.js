import "bootstrap";
import { onlyOneBox } from '../onlyOneBox';
import { socialMediaForms } from '../applySocialMediaForms';
import { expandConfirm } from '../welcomeCallCalendar';
import { showUserInfo } from '../welcomeCallCalendar';
import { noNavbar } from '../noNavbar';
import { checkDates } from '../bookingDates';

onlyOneBox();
socialMediaForms();
expandConfirm();
showUserInfo();
noNavbar();
checkDates();
